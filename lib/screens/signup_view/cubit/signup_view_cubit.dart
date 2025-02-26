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
        'type': "default",
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

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter a first name";
    } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
      return "Enter a valid name";
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter a Last name";
    } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
      return "Enter a valid name";
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a phone number";
    } else if (!RegExp(r"^[0-9]{11}$").hasMatch(value)) {
      return "Please enter a valid phone number";
    }
    return null;
  }

  String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your location';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter an email";
    } else if (!RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter the same password";
    } else if (value != passwordController.text) {
      return "Passwords does not match";
    }
    return null;
  }
}
