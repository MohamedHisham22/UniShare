import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        CircleAvatar(
          radius: width * 0.12,
          backgroundImage: AssetImage('assets/images/User image.png'),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey Alice',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: Color(0xffFF5A5F),
              ),
            ),
          ],
        ),
        Spacer(),
        Icon(Icons.menu, size: 33),
      ],
    );
  }
}
