import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:unishare/screens/main_view/views/main_view.dart';

part 'signup_view_state.dart';

class SignupViewCubit extends Cubit<SignupViewState> {
  SignupViewCubit() : super(SignupViewInitial());
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedLocation;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void setLocation(String location) {
    selectedLocation = location;
  }

  void signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required String location,
  }) async {
    emit(SignupLoading());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = credential.user!.uid;
      await firestore.collection('users').doc(uid).set({
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'location': location,
        'email': email,
        'createdAt': DateTime.now().toIso8601String(),
      });
      emit(SignupSuccess());
      Navigator.pushNamedAndRemoveUntil(context, MainView.id, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailed(errorMessage: 'Weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupFailed(errorMessage: 'This email already exists'));
      }
    } catch (e) {
      emit(
        SignupFailed(errorMessage: 'Couldnt signup please try again later.'),
      );
    }
  }
}
