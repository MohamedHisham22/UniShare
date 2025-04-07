import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:unishare/firebase_options.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';
import 'package:unishare/screens/add_item_view/views/add_item_view.dart';
import 'package:unishare/screens/chat_view/cubit/all_chats_view_cubit.dart';
import 'package:unishare/screens/chat_view/views/all_chats_view.dart';
import 'package:unishare/screens/explore_view/views/explore_view.dart';
import 'package:unishare/screens/home_view/cubit/get_items_cubit.dart';
import 'package:unishare/screens/home_view/views/home_view.dart';
import 'package:unishare/screens/listing_view/views/listing_view.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';
import 'package:unishare/screens/login_view/views/login_view.dart';
import 'package:unishare/screens/main_view/cubit/main_view_cubit.dart';
import 'package:unishare/screens/main_view/views/main_view.dart';
import 'package:unishare/screens/saved_view/views/saved_view.dart';
import 'package:unishare/screens/settings_view/views/settings_view.dart';
import 'package:unishare/screens/signup_view/cubit/signup_view_cubit.dart';
import 'package:unishare/screens/signup_view/views/signup_view.dart';
import 'package:unishare/screens/signup_view/views/signup_view_2.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/carousel_slider_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/views/tool_details_view_client.dart';
import 'package:unishare/screens/tool_details_view_user/views/tool_details_view_user.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:unishare/screens/update_profile/views/update_profile.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DioHelper.init();

  runApp(const MyApp());
  await Future.delayed(Duration(seconds: 5));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginViewCubit()..startAppWithUserData(),
        ),
        BlocProvider(create: (context) => SignupViewCubit()),
        BlocProvider(create: (context) => MainViewCubit()),
        BlocProvider(create: (context) => GetItemsCubit()..getItems()),
        BlocProvider(
          create:
              (context) =>
                  AddItemsCubit(getItemsCubit: context.read<GetItemsCubit>()),
        ),

        BlocProvider(create: (context) => CarouselSliderCubit()),
        BlocProvider(create: (context) => AllChatsViewCubit()),
        BlocProvider(
          create: (context) => UpdateProfileCubit()..startAppWithProfileImage(),
        ),
        BlocProvider(create: (context) => ToolDetailesClientViewCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:
            FirebaseAuth.instance.currentUser == null
                ? LoginView.id
                : MainView.id,
        routes: {
          LoginView.id: (context) => LoginView(),
          SignupView.id: (context) => SignupView(),
          SignupView2.id: (context) => SignupView2(),
          MainView.id: (context) => MainView(),
          HomeView.id: (context) => HomeView(),
          ExploreView.id: (context) => ExploreView(),
          ListingView.id: (context) => ListingView(),
          AddItemView.id: (context) => AddItemView(),
          SavedView.id: (context) => SavedView(),
          ToolDetailsViewClient.id: (context) => ToolDetailsViewClient(),
          ToolDetailsViewUser.id: (context) => ToolDetailsViewUser(),
          AllChatsView.id: (context) => AllChatsView(),
          SettingsView.id: (context) => SettingsView(),
          UpdateProfile.id: (context) => UpdateProfile(),
        },
      ),
    );
  }
}
