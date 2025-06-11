import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class ExploreRecentlyTools extends StatelessWidget {
  const ExploreRecentlyTools({super.key, required this.recentlyItem});
  final RecentlyViewModel recentlyItem;

  Future<Map<String, dynamic>> getUserData(String userId) async {
    if (userId.isEmpty) {
      print('Error: Empty user ID');
      return {};
    }

    try {
      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();

      if (!userDoc.exists) {
        print('User document does not exist for ID: $userId');
        return {};
      }

      final data = userDoc.data();
      print('Retrieved user data: $data');
      return data ?? {};
    } catch (e) {
      print('Error fetching user data: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final itemDetailesCubit = context.read<ToolDetailesClientViewCubit>();
    String userID = FirebaseAuth.instance.currentUser?.uid ?? '';
    print(
      'Building ExploreRecentlyTools for user: ${recentlyItem.createdUserId}',
    );

    return GestureDetector(
      onTap: () {
        itemDetailesCubit.showItemDetailes(
          itemID: recentlyItem.itemId!,
          userID: userID,
        );

        Navigator.pushNamed(context, ToolDetailsViewClient.id);
        context.read<RecentlyViewedCubit>().recentlyView(userID);
      },
      child: Container(
        width: double.infinity,
        height: height * 0.45,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: getUserData(recentlyItem.createdUserId ?? ''),
              builder: (context, snapshot) {
                final userData = snapshot.data ?? {};
                print('User Data: $userData');

                final firstName = userData['firstName'] ?? '';
                final lastName = userData['lastName'] ?? '';
                final userName = '$firstName $lastName'.trim();
                final displayName =
                    userName.isNotEmpty ? userName : 'Unknown User';
                final profileImageUrl = userData['profileImageUrl'];

                print('Profile Image URL: $profileImageUrl');

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildUserRow(
                    width,
                    AssetImage('assets/images/User image.png'),
                    'Loading...',
                  );
                }

                if (snapshot.hasError) {
                  return _buildUserRow(
                    width,
                    AssetImage('assets/images/User image.png'),
                    'Error loading user',
                  );
                }

                return _buildUserRow(
                  width,
                  profileImageUrl != null
                      ? CachedNetworkImageProvider(profileImageUrl)
                      : AssetImage('assets/images/User image.png'),
                  displayName,
                );
              },
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Container(
                height: height * 0.37,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 4), // ظل لتحت
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                ),
                child: Column(
                  children: [
                    NewToolsImageContainer(
                      imageUrl:
                          recentlyItem.imageUrl ?? 'assets/images/tools.png',
                      height: height * 0.25,
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
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                        ),
                                        child: Text(
                                          recentlyItem.itemName ??
                                              'Unnamed Item',
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
                            ],
                          ),
                          // Spacer(),
                          // Icon(CupertinoIcons.heart, color: Colors.red),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserRow(double width, ImageProvider imageProvider, String name) {
    return Row(
      children: [
        CircleAvatar(radius: width * 0.052, backgroundImage: imageProvider),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: TextStyle(fontSize: 15),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
