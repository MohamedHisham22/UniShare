import 'package:flutter/material.dart';
import 'package:unishare/screens/listing_view/widgets/messaging.dart';

class ListingToolsDetails extends StatelessWidget {
  const ListingToolsDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 114,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffdcedef),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage('assets/images/tools.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Tool Name',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xff616161),
                  ),
                ),
                Messaging(),
                Text(
                  '03 May 2021',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xffC1839F),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


