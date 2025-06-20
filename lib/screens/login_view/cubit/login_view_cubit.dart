import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/helpers/hive_helper.dart';
import 'package:unishare/screens/admin_interface/views/admin_home_view.dart';
import 'package:unishare/screens/home_view/cubit/cubit/recently_viewed_cubit.dart';
import 'package:unishare/screens/listing_view/cubit/my_listing_cubit.dart';
import 'package:unishare/screens/login_view/model/user_model.dart';
import 'package:unishare/screens/login_view/views/login_view.dart';
import 'package:unishare/screens/main_view/views/main_view.dart';
import 'package:unishare/screens/saved_view/cubit/favorite_items_cubit_cubit.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';

part 'login_view_state.dart';

class LoginViewCubit extends Cubit<LoginViewState> {
  LoginViewCubit() : super(LoginViewInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserModel? userModel;

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
      await getUserData();
      final userBox = Hive.box<UserModel>('userBox');
      if (userModel != null) {
        userBox.put('user', userModel!);
      }
      await context.read<UpdateProfileCubit>().getProfilePicture(
        FirebaseAuth.instance.currentUser?.uid ?? '',
      );
      //?????????????????
      await context.read<MyListingCubit>().getItems(
        FirebaseAuth.instance.currentUser?.uid ?? '',
      );
      await context.read<FavoriteItemsCubit>().getFavoriteItems(
        userId: FirebaseAuth.instance.currentUser?.uid ?? '',
      );
      await context.read<RecentlyViewedCubit>().recentlyView(
        FirebaseAuth.instance.currentUser?.uid ?? '',
      );
      String user = FirebaseAuth.instance.currentUser?.uid ?? '';
      final DocumentSnapshot snapShot =
          await FirebaseFirestore.instance.collection('users').doc(user).get();
      String role = snapShot['role'];
      emit(LoginSuccess());
      if (role == 'admin') {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AdminHomeView.id,
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainView.id,
          (route) => false,
        );
      }
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
            'profileImageUrl': 'http://unishare.runasp.net/images/a7c1eadb-dda0-4c8d-ae25-f3c8e78c229f_37.png',
            'firstName': user.displayName?.split(" ").first ?? "",
            'lastName': user.displayName?.split(" ").last ?? "",
            'phone': "Not Determined",
            'location': "Not Determined",
            'email': user.email,
            'password': 'no password for a google account',
            'type': "google account",
            'createdAt': FieldValue.serverTimestamp(),
            'role': 'user',
          });
          //! send user id to the backend database
          FormData formData = FormData.fromMap({"UserId": user.uid});
          await DioHelper.postFormData(
            path: 'http://unishare.runasp.net/api/users',
            body: formData,
          );
          //! sent user id to backend complete normally...
        }
       await getUserData(); 
if (userModel != null) {
  final userBox = Hive.box<UserModel>('userBox');
  await userBox.put('user', userModel!); 
}
        await context.read<UpdateProfileCubit>().getProfilePicture(
          FirebaseAuth.instance.currentUser?.uid ?? '',
        );
        await context.read<MyListingCubit>().getItems(
          FirebaseAuth.instance.currentUser?.uid ?? '',
        );
        await context.read<FavoriteItemsCubit>().getFavoriteItems(
          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
        );
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
    try {
      GoogleSignIn().disconnect();
      await FirebaseAuth.instance.signOut();
      await HiveHelper.clearHive();

      emit(SigningOutSuccess());
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginView.id,
        (route) => false,
      );
      context.read<RecentlyViewedCubit>().clearRecentlyItems();
    } catch (e) {
      emit(SigningOutFailed(errorMessage: 'Couldn\'t sign out'));
    }
  }

  Future<void> getUserData() async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    final userDoc = await firestore.collection('users').doc(userID).get();
    if (userDoc.exists && userDoc.data() != null) {
      userModel = UserModel.fromSnapshot(
        userDoc.data() as Map<String, dynamic>,
      );
      emit(GettingDataSuccess());
    }
  }

  void startAppWithUserData() async {
    if (FirebaseAuth.instance.currentUser != null && userModel == null) {
      await getUserData();
    }
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
