import 'package:flutter/material.dart';

class UpdateTextField extends StatelessWidget {
  const UpdateTextField({
    super.key,
    required this.fieldController,
    required this.hintText,
    required this.clearingFunction,
    required this.isPassword,
    required this.fieldValidator,
  });

  final TextEditingController fieldController;
  final String hintText;
  final VoidCallback clearingFunction;
  final bool isPassword;
  final FormFieldValidator<String> fieldValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: fieldValidator,
      controller: fieldController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: const Color.fromARGB(255, 111, 111, 111)),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: clearingFunction,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 220, 220, 220),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      obscureText: isPassword ? true : false,
    );
  }
}
