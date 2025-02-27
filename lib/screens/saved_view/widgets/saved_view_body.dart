import 'package:flutter/material.dart';
import 'package:unishare/screens/saved_view/widgets/saved_tools_list_view.dart';

class SavedViewBody extends StatelessWidget {
  const SavedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(children: [SavedToolsListView()]),
    );
  }
}
