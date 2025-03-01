import 'package:flutter/material.dart';

class CustomTextFieldDuration extends StatefulWidget {
  const CustomTextFieldDuration({super.key});

  @override
  State<CustomTextFieldDuration> createState() =>
      _CustomTextFieldDurationState();
}

class _CustomTextFieldDurationState extends State<CustomTextFieldDuration> {
  String? selectedMonth;

  final List<String> months = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      height: 55,
      child: DropdownButtonFormField<String>(
        value: selectedMonth,
        onChanged: (value) {
          setState(() {
            selectedMonth = value;
          });
        },
        decoration: InputDecoration(
          fillColor: Color(0xffEAEAEA),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        hint: Text(
          'Weekly',
          style: TextStyle(fontSize: 16, color: Color(0xff656565)),
        ),
        items:
            months.map((month) {
              return DropdownMenuItem(
                value: month,
                child: Text(
                  month,
                  style: TextStyle(fontSize: 16, color: Color(0xff656565)),
                ),
              );
            }).toList(),
      ),
    );
  }
}
