import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';

class DarkAndNotifi extends StatelessWidget {
  const DarkAndNotifi({
    super.key,
    required this.value,
    this.onChanged,
    required this.text,
  });
  final bool value;
  final Function(bool)? onChanged;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        Spacer(),
        Switch(
          activeColor:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : kPrimaryColor,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
