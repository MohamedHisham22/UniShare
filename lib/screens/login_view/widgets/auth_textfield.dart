import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';

class AuthTextField extends StatefulWidget {
  AuthTextField({
    required this.height,
    required this.width,
    required this.hintText,
    required this.fieldValidation,
    this.fieldController,
    this.isThisAPassword = false,
    this.isThisAPhoneNumber = false,
    this.textFieldWidth = double.infinity,
  });

  final double height;
  final double width;
  final String hintText;
  final bool isThisAPassword;
  final bool isThisAPhoneNumber;
  final double textFieldWidth;
  final FormFieldValidator<String> fieldValidation;
  final TextEditingController? fieldController;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool istextObsecured = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.textFieldWidth,
      child: TextFormField(
        keyboardType:
            widget.isThisAPhoneNumber
                ? TextInputType.numberWithOptions()
                : null,
        controller: widget.fieldController,
        validator: widget.fieldValidation,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Color.fromARGB(255, 102, 101, 101),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: widget.height * 0.02,
            horizontal: widget.width * 0.05,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon:
              widget.isThisAPassword
                  ? GestureDetector(
                    onTap: () {
                      istextObsecured = !istextObsecured;
                      setState(() {});
                    },
                    child: Icon(
                      istextObsecured ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                  : null,
        ),
        obscureText: widget.isThisAPassword ? istextObsecured : false,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
      ),
    );
  }
}
