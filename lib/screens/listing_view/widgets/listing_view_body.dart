import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unishare/screens/listing_view/widgets/listing_tools_list_view.dart';

class ListingViewBody extends StatelessWidget {
  const ListingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(children: [ListingToolsListView()]),
    );
  }
}
