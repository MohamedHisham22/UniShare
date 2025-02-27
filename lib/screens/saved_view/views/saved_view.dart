import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/saved_view/widgets/saved_view_body.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});
  static String id = '/saved';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        title: Text(
          'Liked items',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: kPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SavedViewBody(),
    );
  }
}
