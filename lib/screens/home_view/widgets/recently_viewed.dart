import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unishare/screens/home_view/widgets/new_tools_image_container.dart';

class RecentlyViewed extends StatelessWidget {
  const RecentlyViewed({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.65,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(41, 0, 0, 0), // Shadow color
            spreadRadius: 1, // How much the shadow spreads
            blurRadius: 6, // Softness of the shadow
            offset: Offset(4, 4), // Changes position of shadow (X, Y)
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          NewToolsImageContainer(
            height: height * 0.21,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tool Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '2018 | FunSkool',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
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
