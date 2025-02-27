import 'package:flutter/material.dart';
import 'package:unishare/screens/saved_view/widgets/saved_tools.dart';

class SavedToolsListView extends StatelessWidget {
  const SavedToolsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (c, i) => SavedTools(),
        separatorBuilder: (c, i) => SizedBox(height: 10),
        itemCount: 10,
      ),
    );
  }
}
