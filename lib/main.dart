import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:unishare/screens/home_view/views/home_view.dart';
import 'package:unishare/screens/login_view/views/login_view.dart';
import 'package:unishare/screens/main_view/views/main_view.dart';
import 'package:unishare/screens/signup_view/views/signup_view.dart';
import 'package:unishare/screens/signup_view/views/signup_view_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginView.id,
      routes: {
        LoginView.id: (context) => LoginView(),
        SignupView.id: (context) => SignupView(),
        SignupView2.id: (context) => SignupView2(),
        MainView.id: (context) => MainView(),
        HomeView.id: (context) => HomeView(),
      },
    );
  }
}
