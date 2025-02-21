import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';

class AuthQuestion extends StatelessWidget {
  AuthQuestion({
    required this.width,
    required this.route,
    required this.question,
    required this.textButton,
  });

  final double width;
  final String route;
  final String question;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question, style: TextStyle(fontSize: width * 0.043)),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          child: Text(
            textButton,
            style: TextStyle(color: kPrimaryColor, fontSize: width * 0.043),
          ),
        ),
      ],
    );
  }
}
