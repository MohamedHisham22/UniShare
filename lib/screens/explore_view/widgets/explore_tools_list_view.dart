import 'package:flutter/material.dart';
import 'package:unishare/screens/explore_view/widgets/explore_tools.dart';

class ExploreToolsListView extends StatelessWidget {
  const ExploreToolsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (c, i) => ExploreTools(),
      separatorBuilder: (c, i) => SizedBox(height: 10),
      itemCount: 5,
    );
  }
}