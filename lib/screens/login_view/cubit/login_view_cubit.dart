import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:unishare/screens/login_view/views/login_view.dart';
import 'package:unishare/screens/main_view/views/main_view.dart';

part 'login_view_state.dart';

class LoginViewCubit extends Cubit<LoginViewState> {
  LoginViewCubit() : super(LoginViewInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void checkingIfSignedIn({required BuildContext context}) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, LoginView.id);
      } else {
        Navigator.pushReplacementNamed(context, MainView.id);
      }
    });
  }

  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
      Navigator.pushNamedAndRemoveUntil(context, MainView.id, (route) => false);
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'invalid-credential') {
        emit(LoginFailed(errorMessage: 'Wrong email or password'));
      }
    } catch (ex) {
      emit(LoginFailed(errorMessage: 'Couldnt signin please try again later'));
    }
  }

  Future signInWithGoogle({required BuildContext context}) async {
    emit(LoginLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        emit(LoginFailed(errorMessage: 'Google sign-in was canceled'));
        return;
      }

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        final userDoc = await firestore.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          await firestore.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'firstName': user.displayName?.split(" ").first ?? "",
            'lastName': user.displayName?.split(" ").last ?? "",
            'phone': "",
            'location': "",
            'email': user.email,
            'type': "google account",
            'createdAt': FieldValue.serverTimestamp(),
          });
        }

        emit(LoginSuccess());
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainView.id,
          (route) => false,
        );
      }
    } catch (e) {
      emit(LoginFailed(errorMessage: 'Google sign-in failed'));
    }
  }

  void signOut({required BuildContext context}) async {
    emit(SigningOutLoading());
    await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut();
    emit(SigningOutSuccess());
    Navigator.pushNamedAndRemoveUntil(context, LoginView.id, (route) => false);
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    } else if (!RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }
}
