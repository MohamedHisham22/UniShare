import 'package:flutter/material.dart';

class AuthInfo extends StatelessWidget {
  AuthInfo({required this.text, required this.width});
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: width * 0.036));
  }
}
