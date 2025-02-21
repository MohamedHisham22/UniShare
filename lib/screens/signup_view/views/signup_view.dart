import 'package:flutter/material.dart';

import 'package:unishare/screens/login_view/views/login_view.dart';
import 'package:unishare/screens/login_view/widgets/auth_button.dart';
import 'package:unishare/screens/login_view/widgets/auth_info.dart';
import 'package:unishare/screens/login_view/widgets/auth_question.dart';
import 'package:unishare/screens/login_view/widgets/auth_textfield.dart';
import 'package:unishare/screens/login_view/widgets/auth_title.dart';
import 'package:unishare/screens/signup_view/views/signup_view_2.dart';

import 'package:unishare/screens/signup_view/widgets/drop_down_menu.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static String id = '/signup';
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
                Row(
                  children: [
                    AuthTextField(
                      height: height,
                      width: width,
                      hintText: 'First Name',
                      textFieldWidth: width * 0.38,
                    ),
                    Spacer(),
                    AuthTextField(
                      height: height,
                      width: width,
                      hintText: 'Last Name',
                      textFieldWidth: width * 0.38,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.032),
                AuthTextField(
                  height: height,
                  width: width,
                  hintText: 'Phone Number',
                ),
                SizedBox(height: height * 0.032),
                AuthDropdown(width: width, height: height),
                SizedBox(height: height * 0.05),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignupView2.id);
                  },
                  child: AuthButton(height: height, width: width, text: 'Next'),
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
    );
  }
}
