import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/login_view/views/login_view.dart';
import 'package:unishare/screens/main_view/views/main_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static String id = '/splash';
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4)).then((val) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, LoginView.id);
        } else {
          Navigator.pushReplacementNamed(context, MainView.id);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: EdgeInsets.only(bottom: height * 0.080),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath + 'logo.png'),
              SizedBox(height: 35),
              Image.asset(imagePath + 'UniShare SHARE, SUPPORT, SUSTAIN.png'),
            ],
          ),
        ),
      ),
    );
  }
}
