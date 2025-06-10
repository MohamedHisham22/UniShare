import 'package:flutter/material.dart';
import 'package:unishare/screens/confirm_update_screens/views/confirming_password_update_view.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Password',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Color(0xffEAEAEA),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  text.replaceAll(RegExp(r"."), "*"),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () {
                  Navigator.pushNamed(context, ConfirmingPasswordUpdateView.id);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
