import 'package:flutter/material.dart';
import 'package:unishare/screens/login_view/views/login_view.dart';
import 'package:unishare/screens/login_view/widgets/auth_button.dart';
import 'package:unishare/screens/login_view/widgets/auth_info.dart';
import 'package:unishare/screens/login_view/widgets/auth_question.dart';
import 'package:unishare/screens/login_view/widgets/auth_textfield.dart';
import 'package:unishare/screens/login_view/widgets/auth_title.dart';

class SignupView2 extends StatelessWidget {
  const SignupView2({super.key});

  static String id = '/signup2';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: height * 0.12,
            right: width * 0.085,
            left: width * 0.085,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthTitle(width: width, title: 'Sign up'),
                SizedBox(height: height * 0.032),
                AuthInfo(
                  width: width,
                  text: 'please fillup the following information',
                ),
                SizedBox(height: height * 0.032),
                AuthTextField(height: height, width: width, hintText: 'Email'),

                SizedBox(height: height * 0.032),
                AuthTextField(
                  height: height,
                  width: width,
                  hintText: 'Password',
                  isThisAPassword: true,
                ),
                SizedBox(height: height * 0.032),
                AuthTextField(
                  height: height,
                  width: width,
                  hintText: 'Confirm Pasword',
                  isThisAPassword: true,
                ),

                SizedBox(height: height * 0.05),
                AuthButton(height: height, width: width, text: 'Sign up'),
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
    );
  }
}
