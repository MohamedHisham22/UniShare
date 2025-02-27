import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedTools extends StatelessWidget {
  const SavedTools({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.end,
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

                Text(
                  '03 May 2021',
                  style: TextStyle(fontSize: 18, color: Color(0xffC1839F)),
                ),
              ],
            ),
            Spacer(),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Icon(CupertinoIcons.heart_fill, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
