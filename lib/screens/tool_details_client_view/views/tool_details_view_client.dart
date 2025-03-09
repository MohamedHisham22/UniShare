import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/tool_details_view_client_body.dart';

class ToolDetailsViewClient extends StatelessWidget {
  static String id = '/toolDetailsClient';
  const ToolDetailsViewClient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: BackBotton(),
      //   automaticallyImplyLeading: false,
      //   toolbarHeight: 70,
      //   surfaceTintColor: Colors.transparent,
      // ),
      body: ToolDetailsViewClientBody(),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          border: Border.all(color: Colors.grey, width: 0.8),
          //  Border(
          //   // top: BorderSide(color: Colors.grey, width: 0.9),
          //   // right: BorderSide(color: Colors.grey, width: 0.5),
          //   // left: BorderSide(color: Colors.grey, width: 0.5),

          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price', style: TextStyle(fontSize: 20)),
                  Text(
                    '150 EGP/Month',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kPrimaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Row(
                      children: [
                        Icon(Icons.chat_bubble_outline, color: Colors.white),
                        Spacer(),
                        Text(
                          'Open Chat',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
