import 'package:flutter/material.dart';

class UploadImageBotton extends StatelessWidget {
  const UploadImageBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xff062D58),
      ),
      child: Center(
        child: Text(
          'Click here to add image',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}