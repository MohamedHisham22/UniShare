import 'package:flutter/material.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';

class ToolDescription extends StatefulWidget {
  const ToolDescription({super.key, required this.itemsDetailCubit});
  final ToolDetailesClientViewCubit itemsDetailCubit;

  @override
  State<ToolDescription> createState() => _ToolDescriptionState();
}

class _ToolDescriptionState extends State<ToolDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              text:
                  widget.itemsDetailCubit.itemDetailes.itemDescription ??
                  'Loading',

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
