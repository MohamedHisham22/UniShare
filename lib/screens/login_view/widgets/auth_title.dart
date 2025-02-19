import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unishare/constants.dart';

class AuthTitle extends StatelessWidget {
  AuthTitle({
    required this.width,
    required this.title,
  });

  final double width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(
          flex: 2,
        ),
        SizedBox(
            width: width * 0.155,
            height: width * 0.16,
            child: Image.asset(
              imagePath + 'logo.png',
            )),
        SizedBox(
          width: width * 0.04,
        ),
        Text(
          title,
          style: GoogleFonts.dosis(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w900, fontSize: width * 0.127)),
        ),
        Spacer(
          flex: 3,
        )
      ],
    );
  }
}
