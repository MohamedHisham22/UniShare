import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:unishare/screens/login_view/views/login_view.dart';
import 'package:unishare/screens/main_view/views/main_view.dart';

part 'login_view_state.dart';

class LoginViewCubit extends Cubit<LoginViewState> {
  LoginViewCubit() : super(LoginViewInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

  void signOut({required BuildContext context}) async {
    emit(SigningOutLoading());
    await FirebaseAuth.instance.signOut();
    emit(SigningOutSuccess());
    Navigator.pushNamedAndRemoveUntil(context, LoginView.id, (route) => false);
  }
}
