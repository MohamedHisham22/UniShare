import 'package:flutter/material.dart';

import 'package:unishare/screens/login_view/widgets/auth_button.dart';
import 'package:unishare/screens/login_view/widgets/auth_info.dart';
import 'package:unishare/screens/login_view/widgets/auth_question.dart';
import 'package:unishare/screens/login_view/widgets/auth_textfield.dart';
import 'package:unishare/screens/login_view/widgets/auth_title.dart';
import 'package:unishare/screens/login_view/widgets/divider.dart';
import 'package:unishare/screens/login_view/widgets/google_signin.dart';
import 'package:unishare/screens/main_view/views/main_view.dart';
import 'package:unishare/screens/signup_view/views/signup_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  static String id = '/login';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(right: width * 0.085, left: width * 0.085),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.12),
                  AuthTitle(width: width, title: 'Sign in'),
                  SizedBox(height: height * 0.032),
                  AuthInfo(
                    width: width,
                    text: 'Sign in with one of the following options',
                  ),
                  SizedBox(height: height * 0.032),
                  GoogleSignIn(height: height, width: width),
                  AuthDivider(height: height),
                  AuthTextField(
                    height: height,
                    width: width,
                    hintText: 'Email',
                    isThisAPassword: false,
                    fieldController: _emailController,
                    fieldValidation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      } else if (!RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                      ).hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.032),
                  AuthTextField(
                    height: height,
                    width: width,
                    hintText: 'Password',
                    isThisAPassword: true,
                    fieldController: _passwordController,
                    fieldValidation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.05),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          MainView.id,
                          (route) => false,
                        );
                      }
                    },
                    child: AuthButton(
                      height: height,
                      width: width,
                      text: 'Sign in',
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  AuthQuestion(
                    width: width,
                    route: SignupView.id,
                    question: 'Dont\'t have an account?',
                    textButton: 'Sign up',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
