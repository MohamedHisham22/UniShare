import 'package:flutter/material.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';

class ToolDescription extends StatelessWidget {
  const ToolDescription({super.key, required this.itemsDetailCubit});
  final ToolDetailesClientViewCubit itemsDetailCubit;

  @override
  Widget build(BuildContext context) {
    return Text(
      itemsDetailCubit.itemDetailes.itemDescription ?? 'Loading',
      style: TextStyle(
        fontSize: 14,
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Color(0xff666666),
      ),
    );
  }
}
