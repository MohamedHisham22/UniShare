import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/refresh_app.dart';
import 'package:unishare/screens/chat_view/cubit/all_chats_view_cubit.dart';
import 'package:unishare/screens/home_view/widgets/home_view_body.dart';
import 'package:unishare/screens/home_view/widgets/menu_drawer.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = '/home';
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AllChatsViewCubit>();
    final loginCubit = context.read<LoginViewCubit>();
    final profileCubit = context.read<UpdateProfileCubit>();

    return Scaffold(
      drawer: menuDrawer(cubit, context, loginCubit, profileCubit),
      body: RefreshIndicator(
        onRefresh: () async {
          RefreshApp.restartApp(context);
        },
        child: SafeArea(child: HomeViewBody()),
      ),
    );
  }
}
