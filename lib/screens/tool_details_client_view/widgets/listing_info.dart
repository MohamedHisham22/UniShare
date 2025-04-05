import 'package:flutter/material.dart';

class ListingInfo extends StatelessWidget {
  const ListingInfo({super.key, required this.text, required this.type});
  final String text;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(width: 10),
        Text(type, style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
