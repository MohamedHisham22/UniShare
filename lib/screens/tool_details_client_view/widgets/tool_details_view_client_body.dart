import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/explore_view/widgets/back_botton.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/carousel_slider_images.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/listing_info.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/tool_description.dart';

class ToolDetailsViewClientBody extends StatelessWidget {
  const ToolDetailsViewClientBody({super.key});

  @override
  Widget build(BuildContext context) {
    final itemsDetailCubit = context.read<ToolDetailesClientViewCubit>();
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(child: BackBotton()),
            SizedBox(height: 20),
            CarouselSliderImages(),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  itemsDetailCubit.itemDetailes.itemName ?? 'Loading',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(CupertinoIcons.heart, color: Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(height: 7),
            ToolDescription(itemsDetailCubit: itemsDetailCubit),
            SizedBox(height: 30),
            Text(
              'Listing Info',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            ListingInfo(
              text: 'Category: ',
              type: itemsDetailCubit.itemDetailes.itemBrand ?? 'Loading',
            ),
            SizedBox(height: 5),
            ListingInfo(
              text: 'Condition: ',
              type: itemsDetailCubit.itemDetailes.itemCondition ?? 'Loading',
            ),
            SizedBox(height: 5),
            ListingInfo(
              text: 'Listing type: ',
              type: itemsDetailCubit.itemDetailes.listingOption ?? 'Loading',
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
