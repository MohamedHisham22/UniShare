import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/firebase_options.dart';
import 'package:unishare/screens/home_view/views/home_view.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';
import 'package:unishare/screens/login_view/views/login_view.dart';
import 'package:unishare/screens/main_view/cubit/main_view_cubit.dart';
import 'package:unishare/screens/main_view/views/main_view.dart';
import 'package:unishare/screens/signup_view/cubit/signup_view_cubit.dart';
import 'package:unishare/screens/signup_view/views/signup_view.dart';
import 'package:unishare/screens/signup_view/views/signup_view_2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginViewCubit()),
        BlocProvider(create: (context) => SignupViewCubit()),
        BlocProvider(create: (context) => MainViewCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginView.id,
        routes: {
          LoginView.id: (context) => LoginView(),
          SignupView.id: (context) => SignupView(),
          SignupView2.id: (context) => SignupView2(),
          MainView.id: (context) => MainView(),
          HomeView.id: (context) => HomeView(),
        },
      ),
    );
  }
}
