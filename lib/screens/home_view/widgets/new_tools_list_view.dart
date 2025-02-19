import 'package:flutter/cupertino.dart';
import 'package:unishare/screens/home_view/widgets/new_tools.dart';

class NewToolsListView extends StatelessWidget {
  const NewToolsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 246,
      child: ListView.separated(
        itemBuilder: (c, i) => NewTools(),
        separatorBuilder: (c, i) => SizedBox(width: 17),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
