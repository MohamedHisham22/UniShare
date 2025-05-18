import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unishare/screens/home_view/models/recently_view_model/recently_view_model.dart';
import 'package:unishare/screens/home_view/widgets/new_tools_image_container.dart';

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

    print(
      'Building ExploreRecentlyTools for user: ${recentlyItem.createdUserId}',
    );

    return Container(
      width: double.infinity,
      height: height * 0.4,
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
          SizedBox(height: 10),
          NewToolsImageContainer(
            imageUrl: recentlyItem.imageUrl ?? 'assets/images/tools.png',
            height: height * 0.25,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recentlyItem.itemName ?? 'Unnamed Item',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
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
    );
  }

  Widget _buildUserRow(double width, ImageProvider imageProvider, String name) {
    return Row(
      children: [
        CircleAvatar(
          radius: width * 0.052,
          backgroundImage: imageProvider,
          child:
              imageProvider is AssetImage
                  ? null
                  : Icon(Icons.person, color: Colors.white),
        ),
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
