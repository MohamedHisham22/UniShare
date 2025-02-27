import 'package:flutter/material.dart';

class CustomTextFieldDescription extends StatelessWidget {
  const CustomTextFieldDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: null,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        hintText: 'Item Description',
        hintStyle: TextStyle(fontSize: 18, color: Color(0xff656565)),

        fillColor: Color(0xffEAEAEA),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
