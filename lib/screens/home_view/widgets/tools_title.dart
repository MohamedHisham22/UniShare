import 'package:flutter/cupertino.dart';

class ToolsTitle extends StatelessWidget {
  final String text;
  const ToolsTitle({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Text(
          'View more',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xff898989),
          ),
        )
      ],
    );
  }
}
