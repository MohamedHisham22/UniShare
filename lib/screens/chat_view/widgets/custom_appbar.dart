import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';

AppBar CustomAppBar() {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.white,
    toolbarHeight: 85,
    title: Text(
      'Chats',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: kPrimaryColor,
      ),
    ),
    centerTitle: true,
  );
}
