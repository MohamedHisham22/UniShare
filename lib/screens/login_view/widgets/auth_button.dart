import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';

class AuthButton extends StatelessWidget {
  AuthButton({
    required this.height,
    required this.width,
    required this.text,
  });

  final double height;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.063,
      width: double.infinity,
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: width * 0.06),
        ),
      ),
    );
  }
}
