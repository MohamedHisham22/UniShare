import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/explore_view/widgets/back_botton.dart';
import 'package:unishare/screens/settings_view/cubit/switch_cubit.dart';
import 'package:unishare/screens/settings_view/widgets/change_pass_and_about_us.dart';
import 'package:unishare/screens/settings_view/widgets/dark_and_notifi.dart';
import 'package:unishare/screens/settings_view/widgets/setting_title.dart';
import 'package:unishare/theme_provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static String id = '/settings';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocBuilder<SwitchCubit, SwitchState>(
      builder: (context, state) {
        final cubit = context.read<SwitchCubit>();

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 85,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
              child: BackBotton(),
            ),
            title: Text(
              'Setting',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryColor,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingTitle(text: 'Account Settings'),
                SizedBox(height: 40),
                ChangePassAndAboutUs(text: 'Change password'),
                SizedBox(height: 20),
                DarkAndNotifi(
                  text: 'Dark mode',
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
                SizedBox(height: 20),
                DarkAndNotifi(
                  text: 'Notifications',
                  value: cubit.notification,
                  onChanged: (value) {
                    cubit.notifi(value);
                  },
                ),
                SizedBox(height: 100),
                Divider(indent: 15, endIndent: 15),
                SizedBox(height: 50),
                SettingTitle(text: 'More'),
                SizedBox(height: 40),
                ChangePassAndAboutUs(text: 'About us'),
              ],
            ),
          ),
        );
      },
    );
  }
}
