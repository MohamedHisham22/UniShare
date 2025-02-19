import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  AuthDivider({
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: Divider(
        thickness: 3,
        endIndent: 5,
        height: height * 0.11,
      )),
      Text("OR"),
      Expanded(
          child: Divider(
        thickness: 3,
        indent: 5,
      )),
    ]);
  }
}
