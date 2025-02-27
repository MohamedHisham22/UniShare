import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:unishare/screens/explore_view/views/explore_view.dart';

class ToolsTitle extends StatelessWidget {
  final String text;
  const ToolsTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Spacer(),
        GestureDetector(
          onTap: () {
            Get.to(ExploreView());
          },
          child: Text(
            'View more',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff898989),
            ),
          ),
        ),
      ],
    );
  }
}
