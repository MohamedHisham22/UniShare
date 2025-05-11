import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/helpers/hive_helper.dart';
import 'package:unishare/screens/chat_view/cubit/all_chats_view_cubit.dart';
import 'package:unishare/screens/home_view/cubit/cubit/recently_viewed_cubit.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';
import 'package:unishare/screens/settings_view/views/settings_view.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';

Drawer menuDrawer(
  AllChatsViewCubit cubit,
  BuildContext context,
  LoginViewCubit loginCubit,
  UpdateProfileCubit profileCubit,
) {
  return Drawer(
    child: ListView(
      children: [
        BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
          builder: (context, state) {
            return BlocBuilder<LoginViewCubit, LoginViewState>(
              builder: (context, state) {
                return UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  currentAccountPictureSize: Size(68, 68),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        profileCubit.gettingImage.profileImage != null
                            ? NetworkImage(
                              profileCubit.gettingImage.profileImage!,
                            )
                            : AssetImage(imagePath + 'User image.png')
                                as ImageProvider,
                  ),
                  accountName: Text(
                    loginCubit.userModel?.firstName ?? 'N/A',
                    style: TextStyle(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.white,
                    ),
                  ),
                  accountEmail: Text(
                    loginCubit.userModel?.email ?? 'N/A',
                    style: TextStyle(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.white,
                    ),
                  ),
                );
              },
            );
          },
        ),
        const Divider(color: Colors.transparent),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {
            Navigator.pushNamed(context, SettingsView.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () async {
            print("Logout tapped");
            await HiveHelper.clearHive();
             
            print("Boxes should be cleared");
            loginCubit.signOut(context: context);
          },
        ),
      ],
    ),
  );
}
