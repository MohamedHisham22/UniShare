import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/listing_view/widgets/listing_view_body.dart';

class ListingView extends StatelessWidget {
  const ListingView({super.key});
  static String id = '/listings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        title: Text(
          'My Listings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: kPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: ListingViewBody(),
    );
  }
}
