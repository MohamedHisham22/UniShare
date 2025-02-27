import 'package:flutter/material.dart';

class TitleName extends StatelessWidget {
  final String text;
  const TitleName({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
  }
}
