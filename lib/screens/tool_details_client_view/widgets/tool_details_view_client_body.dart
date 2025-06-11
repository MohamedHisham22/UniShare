import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/explore_view/widgets/back_botton.dart';
import 'package:unishare/screens/saved_view/cubit/favorite_items_cubit_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/carousel_slider_images.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/listing_info.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/profile_bars.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/tool_description.dart';

class ToolDetailsViewClientBody extends StatelessWidget {
  const ToolDetailsViewClientBody({super.key});

  @override
  Widget build(BuildContext context) {
    final itemsDetailCubit = context.read<ToolDetailesClientViewCubit>();
    final cubit = context.read<FavoriteItemsCubit>();
    String userID = itemsDetailCubit.itemDetailes.userId ?? '';

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                SafeArea(child: BackBotton()),
                Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder:
                            (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              padding: EdgeInsets.all(20),
                              child: FutureBuilder<DocumentSnapshot>(
                                future:
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userID)
                                        .get(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  final userData =
                                      snapshot.data!.data()
                                          as Map<String, dynamic>;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: 50,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: buildInfoField(
                                              'First Name',
                                              userData['firstName'] ?? '',
                                              context,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Expanded(
                                            child: buildInfoField(
                                              'Last Name',
                                              userData['lastName'] ?? '',
                                              context,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),

                                      buildInfoField(
                                        'Email',
                                        userData['email'] ?? '',
                                        context,
                                      ),
                                      SizedBox(height: 15),

                                      buildInfoField(
                                        'Phone Number',
                                        userData['phone'] ?? '',
                                        context,
                                      ),
                                      SizedBox(height: 15),

                                      buildInfoField(
                                        'Location',
                                        userData['location'] ?? '',
                                        context,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                      );
                    },
                    child: FutureBuilder<DocumentSnapshot>(
                      future:
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(userID)
                              .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            'Loading...',
                            style: TextStyle(fontSize: 25),
                          );
                        }

                        final userData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        final userName =
                            userData['firstName'] +
                                ' ' +
                                userData['lastName'] ??
                            'Unknown User';

                        return Text(userName, style: TextStyle(fontSize: 25));
                      },
                    ),
                  ),
                ),
                Spacer(flex: 3),
              ],
            ),
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
                  child: GestureDetector(
                    onTap: () {
                      cubit.toggleFavorite(
                        userId: FirebaseAuth.instance.currentUser?.uid ?? '',
                        itemId: itemsDetailCubit.itemDetailes.itemId ?? '',
                      );
                    },
                    child: BlocBuilder<FavoriteItemsCubit, FavoriteItemsState>(
                      builder: (context, state) {
                        return CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            cubit.isItemFavorited(
                                  itemsDetailCubit.itemDetailes.itemId ?? '',
                                )
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
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
