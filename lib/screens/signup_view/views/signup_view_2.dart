import 'package:flutter/material.dart';
import 'package:unishare/screens/login_view/views/login_view.dart';
import 'package:unishare/screens/login_view/widgets/auth_button.dart';
import 'package:unishare/screens/login_view/widgets/auth_info.dart';
import 'package:unishare/screens/login_view/widgets/auth_question.dart';
import 'package:unishare/screens/login_view/widgets/auth_textfield.dart';
import 'package:unishare/screens/login_view/widgets/auth_title.dart';
import 'package:unishare/screens/main_view/views/main_view.dart';

class SignupView2 extends StatelessWidget {
  SignupView2({super.key});

  static String id = '/signup2';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
                  AuthTitle(width: width, title: 'Sign up'),
                  SizedBox(height: height * 0.032),
                  AuthInfo(
                    width: width,
                    text: 'please fillup the following information',
                  ),
                  SizedBox(height: height * 0.032),
                  AuthTextField(
                    height: height,
                    width: width,
                    hintText: 'Email',
                    fieldController: _emailController,
                    fieldValidation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email";
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
                        return "Please enter a password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.032),
                  AuthTextField(
                    height: height,
                    width: width,
                    hintText: 'Confirm Pasword',
                    isThisAPassword: true,
                    fieldController: _confirmPasswordController,
                    fieldValidation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the same password";
                      } else if (value != _passwordController.text) {
                        return "Passwords does not match";
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
                      text: 'Sign up',
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  AuthQuestion(
                    width: width,
                    route: LoginView.id,
                    question: 'Already have an account?',
                    textButton: 'Sign in',
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
