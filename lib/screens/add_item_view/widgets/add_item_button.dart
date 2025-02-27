import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 239,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kPrimaryColor,
      ),
      child: Center(
        child: Text(
          'Add Item',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
