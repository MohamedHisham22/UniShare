import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        hintText: 'Search for tools and more...',
        hintStyle: TextStyle(
          fontSize: 18,
          color: Color(0xff828282),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(
            CupertinoIcons.search,
            color: Color(0xff999999),
          ),
        ),
        fillColor: Color(0xffDEDEDE),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}