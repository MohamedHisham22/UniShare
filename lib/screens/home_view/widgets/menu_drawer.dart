import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/chat_view/cubit/all_chats_view_cubit.dart';
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
        UserAccountsDrawerHeader(
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
                    ? NetworkImage(profileCubit.gettingImage.profileImage!)
                    : AssetImage(imagePath + 'User image.png'),
          ),
          accountName: Text('username'),
          accountEmail: Text('email'),
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
          onTap: () {
            loginCubit.signOut(context: context);
          },
        ),
      ],
    ),
  );
}
