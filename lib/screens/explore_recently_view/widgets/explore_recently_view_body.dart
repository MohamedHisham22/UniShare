import 'package:flutter/material.dart';
import 'package:unishare/screens/explore_recently_view/widgets/explore_recently_tools_list_view.dart';
import 'package:unishare/screens/explore_recently_view/widgets/search_recently_view.dart';
import 'package:unishare/screens/explore_view/widgets/back_botton.dart';

class ExploreRecentlyViewBody extends StatelessWidget {
  const ExploreRecentlyViewBody({super.key});

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
                  SearchRecentlyView(),
                  ExploreRecentlyToolsListView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
