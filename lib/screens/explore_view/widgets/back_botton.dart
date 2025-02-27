import 'package:flutter/material.dart';

class BackBotton extends StatelessWidget {
  const BackBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xff555555)),
      ),
      child: Center(child: Icon(Icons.arrow_back_ios, size: 16)),
    );
  }
}