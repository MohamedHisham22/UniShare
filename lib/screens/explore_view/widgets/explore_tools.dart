import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unishare/screens/home_view/models/get_items_model/get_items_model.dart';
import 'package:unishare/screens/home_view/widgets/new_tools_image_container.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExploreTools extends StatelessWidget {
  const ExploreTools({super.key, required this.item});
  final GetItemsModel item;

  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
      return userDoc.data() ?? {};
    } catch (e) {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: height * 0.4,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          FutureBuilder<Map<String, dynamic>>(
            future: getUserData(item.userId ?? ''),
            builder: (context, snapshot) {
              final userData = snapshot.data ?? {};
              final userName =
                  '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}'
                      .trim();
              final displayName =
                  userName.isNotEmpty ? userName : 'Unknown User';
              final profileImageUrl = userData['profileImageUrl'];

              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildUserRow(
                  context,
                  width,
                  AssetImage('assets/images/User image.png'),
                  'Loading...',
                );
              }

              if (snapshot.hasError) {
                return _buildUserRow(
                  context,
                  width,
                  AssetImage('assets/images/User image.png'),
                  'Error',
                );
              }

              return _buildUserRow(
                context,
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
            imageUrl: item.imageUrl ?? 'assets/images/tools.png',
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
                      item.itemName ?? 'Unnamed Item',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    // Text(
                    //   '${item.itemYear ?? "Unknown Year"} | ${item.itemBrand ?? "Unknown Brand"}',
                    //   style: TextStyle(fontSize: 14, color: Colors.grey),
                    // ),
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

  Widget _buildUserRow(
    BuildContext context,
    double width,
    ImageProvider imageProvider,
    String name,
  ) {
    return Row(
      children: [
        CircleAvatar(radius: width * 0.052, backgroundImage: imageProvider),
        SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(fontSize: 15),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
