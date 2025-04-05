import 'package:flutter/material.dart';
import 'package:unishare/screens/listing_view/widgets/listing_tools_details.dart';
import 'package:unishare/screens/tool_details_view_user/views/tool_details_view_user.dart';

class ListingToolsListView extends StatelessWidget {
  const ListingToolsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder:
            (c, i) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ToolDetailsViewUser.id);
              },
              child: ListingToolsDetails(),
            ),
        separatorBuilder: (c, i) => SizedBox(height: 10),
        itemCount: 4,
      ),
    );
  }
}
