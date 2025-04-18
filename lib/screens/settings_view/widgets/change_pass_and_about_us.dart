import 'package:flutter/material.dart';

class ChangePassAndAboutUs extends StatelessWidget {
  const ChangePassAndAboutUs({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios, size: 20),
      ],
    );
  }
}
