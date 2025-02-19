import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:unishare/screens/home_view/views/home_view.dart';
import 'package:unishare/screens/main_view/views/main_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MainView.id,
      routes: {
        MainView.id: (context) => MainView(),
        HomeView.id: (context) => HomeView(),
      },
    );
  }
}
