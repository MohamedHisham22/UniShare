import 'package:flutter/material.dart';

class ToolDescription extends StatefulWidget {
  const ToolDescription({super.key});

  @override
  State<ToolDescription> createState() => _ToolDescriptionState();
}

class _ToolDescriptionState extends State<ToolDescription> {
  bool isExpanded = false;

  final String text =
      'Product Designers are responsible for coming up with new product designs that meet the needs and wants of consumers. They will have many duties, such as creating design concepts, drawing ideas to determine Product Designers are responsible for coming up with new product designs that meet the needs and wants of consumers. They will have many duties, such as creating design concepts, drawing ideas to determine ';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              text: isExpanded ? text : text.substring(0, 140) + '...',
              style: TextStyle(fontSize: 14, color: Color(0xff666666)),
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? ' Read Less' : ' Read More',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
