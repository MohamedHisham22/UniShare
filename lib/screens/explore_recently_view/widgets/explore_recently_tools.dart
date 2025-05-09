import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unishare/screens/home_view/models/recently_view_model/recently_view_model.dart';
import 'package:unishare/screens/home_view/widgets/new_tools_image_container.dart';

class ExploreRecentlyTools extends StatelessWidget {
  const ExploreRecentlyTools({super.key, required this.recentlyItem});
final RecentlyViewModel recentlyItem;
  @override
  Widget build(BuildContext context) {
        final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: height * 0.4,
      decoration: BoxDecoration(
        boxShadow: [
          // BoxShadow(
          //   color: const Color.fromARGB(41, 0, 0, 0), // Shadow color
          //   spreadRadius: 1, // How much the shadow spreads
          //   blurRadius: 6, // Softness of the shadow
          //   offset: Offset(4, 4), // Changes position of shadow (X, Y)
          // ),
        ],

        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: width * 0.052,
                backgroundImage: AssetImage('assets/images/User image.png'),
              ),
              SizedBox(width: 8),
              Text('Cliff Hanger', style: TextStyle(fontSize: 15)),
            ],
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
                    // Text(
                    //   '${recentlyItem.?? "Unknown Year"} | ${item.itemBrand ?? "Unknown Brand"}',
                    //   style: TextStyle(fontSize: 14, color: Colors.grey),
                    // ),
                  ],
                ),
                Spacer(),
                Icon(CupertinoIcons.heart, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }
}