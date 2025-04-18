import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';

AppBar CustomAppBar(BuildContext context) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor:
        Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900
            : Colors.white,
    toolbarHeight: 85,
    title: Text(
      'Chats',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : kPrimaryColor,
      ),
    ),
    centerTitle: true,
  );
}
