import 'package:flutter/material.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, color: Color(0xffADADAD)),
    );
  }
}
