import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';

class AuthTextField extends StatefulWidget {
  AuthTextField({
    required this.height,
    required this.width,
    required this.hintText,
    this.isThisAPassword = false,
    this.textFieldWidth = double.infinity,
  });

  final double height;
  final double width;
  final String hintText;
  final bool isThisAPassword;
  final double textFieldWidth;

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
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Color.fromARGB(255, 102, 101, 101)),
          contentPadding: EdgeInsets.symmetric(
            vertical: widget.height * 0.02,
            horizontal: widget.width * 0.05,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor),
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
