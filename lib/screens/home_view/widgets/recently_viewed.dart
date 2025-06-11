import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/home_view/cubit/cubit/recently_viewed_cubit.dart';
import 'package:unishare/screens/home_view/models/recently_view_model/recently_view_model.dart';
import 'package:unishare/screens/home_view/widgets/new_tools_image_container.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/views/tool_details_view_client.dart';

class RecentlyViewed extends StatelessWidget {
  const RecentlyViewed({super.key, required this.item});
  final RecentlyViewModel item;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final itemDetailesCubit = context.read<ToolDetailesClientViewCubit>();
    String userID = FirebaseAuth.instance.currentUser?.uid ?? '';
    return GestureDetector(
      onTap: () {
        itemDetailesCubit.showItemDetailes(
          itemID: item.itemId!,
          userID: userID,
        );

        Navigator.pushNamed(context, ToolDetailsViewClient.id);
        context.read<RecentlyViewedCubit>().recentlyView(userID);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: width * 0.68,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, 4), // ظل لتحت
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, -4), // ظل لفوق
              ),
            ],
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              NewToolsImageContainer(
                imageUrl: item.imageUrl ?? 'assets/images/tools.png',
                height: height * 0.21,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              SizedBox(height: 7),
              Divider(
                endIndent: 20,
                indent: 20,
                color: Colors.grey,
                thickness: 0.7,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: kPrimaryColor,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 10.0,
                                    left: 10,
                                  ),
                                  child: Text(
                                    item.itemName ?? 'Unnamed Item',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   'Price / ${item.itemPrice}',
                        //   style: TextStyle(fontSize: 14, color: Colors.grey),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
