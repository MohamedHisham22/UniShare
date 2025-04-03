import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unishare/screens/update_profile/views/update_profile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static String id = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: Text('Update Profile', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.pushNamed(context, UpdateProfile.id);
          },
        ),
      ),
    );
  }
}
