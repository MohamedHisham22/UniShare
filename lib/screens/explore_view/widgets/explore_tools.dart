import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/home_view/cubit/cubit/recently_viewed_cubit.dart';
import 'package:unishare/screens/home_view/models/get_items_model/get_items_model.dart';
import 'package:unishare/screens/home_view/widgets/new_tools_image_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/views/tool_details_view_client.dart';

class ExploreTools extends StatelessWidget {
  const ExploreTools({super.key, required this.item});
  final GetItemsModel item;

  // Cache for user data to prevent repeated network requests
  static final Map<String, Map<String, dynamic>> _userDataCache = {};

  Future<Map<String, dynamic>> getUserData(String userId) async {
    if (_userDataCache.containsKey(userId)) {
      return _userDataCache[userId]!;
    }
    
    try {
      if (userId.isEmpty) return {};
      
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      
      final data = userDoc.data() ?? {};
      _userDataCache[userId] = data;
      return data;
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      return {};
    }
  }

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
      child: Container(
        width: double.infinity,
        height: height * 0.4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: item.userId != null ? getUserData(item.userId!) : Future.value({}),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildUserRow(
                    context,
                    width,
                    const AssetImage('assets/images/User image.png'),
                    'Loading...',
                  );
                }

                if (snapshot.hasError) {
                  debugPrint('Error in FutureBuilder: ${snapshot.error}');
                  return _buildUserRow(
                    context,
                    width,
                    const AssetImage('assets/images/User image.png'),
                    'Error loading user',
                  );
                }

                final userData = snapshot.data ?? {};
                final userName = '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}'.trim();
                final displayName = userName.isNotEmpty ? userName : 'Unknown User';
                final profileImageUrl = userData['profileImageUrl'];

                return _buildUserRow(
                  context,
                  width,
                  profileImageUrl != null
                      ? CachedNetworkImageProvider(profileImageUrl)
                      : const AssetImage('assets/images/User image.png'),
                  displayName,
                );
              },
            ),
            const SizedBox(height: 10),
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
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserRow(
    BuildContext context,
    double width,
    ImageProvider imageProvider,
    String name,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: width * 0.052,
            backgroundImage: imageProvider,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 15),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}