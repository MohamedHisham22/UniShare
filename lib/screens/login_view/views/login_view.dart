import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/login_view/widgets/auth_button.dart';
import 'package:unishare/screens/login_view/widgets/auth_info.dart';
import 'package:unishare/screens/login_view/widgets/auth_textfield.dart';
import 'package:unishare/screens/login_view/widgets/auth_title.dart';
import 'package:unishare/screens/login_view/widgets/divider.dart';
import 'package:unishare/screens/login_view/widgets/google_signin.dart';
import 'package:unishare/screens/signup_view/views/signup_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static String id = '/login';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.12, right: 35, left: 35),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthTitle(width: width, title: 'Sign in'),
                SizedBox(height: height * 0.032),
                AuthInfo(
                  width: width,
                  text: 'Login with one of the following options',
                ),
                SizedBox(height: height * 0.032),
                GoogleSignIn(height: height, width: width),
                AuthDivider(height: height),
                AuthTextField(
                  height: height,
                  width: width,
                  hintText: 'Email',
                  isThisAPassword: false,
                ),
                SizedBox(height: height * 0.032),
                AuthTextField(
                  height: height,
                  width: width,
                  hintText: 'Password',
                  isThisAPassword: true,
                ),
                SizedBox(height: height * 0.05),
                AuthButton(height: height, width: width, text: 'Sign in'),
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont\'t have an account?',
                      style: TextStyle(fontSize: width * 0.043),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignupView.id);
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: width * 0.043,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
