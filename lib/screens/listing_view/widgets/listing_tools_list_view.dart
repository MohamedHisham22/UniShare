import 'package:flutter/material.dart';
import 'package:unishare/screens/listing_view/widgets/listing_tools_details.dart';

class ListingToolsListView extends StatelessWidget {
  const ListingToolsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (c, i) => ListingToolsDetails(),
        separatorBuilder: (c, i) => SizedBox(height: 10),
        itemCount: 4,
      ),
    );
  }
}
