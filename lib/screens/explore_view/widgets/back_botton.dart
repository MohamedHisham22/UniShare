import 'package:flutter/material.dart';

class BackBotton extends StatelessWidget {
  const BackBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Color(0xff555555),
          ),
        ),
        child: Center(child: Icon(Icons.arrow_back_ios, size: 16)),
      ),
    );
  }
}
