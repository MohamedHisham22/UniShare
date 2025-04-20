import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String title;
  final String text;
  final TextInputType? keyboardType;
  final double size;

  const ProfileField({
    Key? key,
    required this.title,
    required this.text,
    required this.size,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: size,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 210, 210, 210),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(text, style: const TextStyle(fontSize: 16)),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
