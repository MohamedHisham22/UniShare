import 'package:flutter/material.dart';
import 'package:unishare/screens/explore_view/widgets/back_botton.dart';
import 'package:unishare/screens/explore_view/widgets/explore_tools_list_view.dart';
import 'package:unishare/screens/explore_view/widgets/custom_text_field.dart';

class ExploreViewBody extends StatelessWidget {
  const ExploreViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
      child: Column(
        children: [
          SafeArea(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: BackBotton(),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CustomTextField(),
                  ExploreToolsListView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
