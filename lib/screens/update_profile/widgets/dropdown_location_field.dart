import 'package:flutter/material.dart';

class LocationDropdownField extends StatelessWidget {
  const LocationDropdownField({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Location',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 210, 210, 210),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(text, style: TextStyle(fontSize: 16)),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.arrow_drop_down_outlined, size: 32),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
