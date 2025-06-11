import 'package:flutter/material.dart';

Widget buildInfoField(String label, String value, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      SizedBox(height: 5),
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromARGB(255, 42, 42, 42)
                  : Colors.grey[200],

          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(value, style: TextStyle(fontSize: 16)),
      ),
    ],
  );
}
