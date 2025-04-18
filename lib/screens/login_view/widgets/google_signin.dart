import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';

class GoogleSignIn extends StatelessWidget {
  GoogleSignIn({required this.height, required this.width});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height * 0.055,
      decoration: BoxDecoration(
        border: Border.all(
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath + 'Google.png'),
          SizedBox(width: 10),
          Text(
            'Sign in with Google',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: width * 0.042,
            ),
          ),
        ],
      ),
    );
  }
}
