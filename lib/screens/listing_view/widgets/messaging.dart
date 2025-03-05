import 'package:flutter/material.dart';

class Messaging extends StatelessWidget {
  const Messaging({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Icon(Icons.mail_outline, size: 18),
            SizedBox(width: 8),

            Text('3'),
          ],
        ),
      ),
    );
  }
}
