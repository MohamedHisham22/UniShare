import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unishare/screens/explore_recently_view/views/explore_recently_view.dart';
import 'package:unishare/screens/explore_view/views/explore_view.dart';
import 'package:unishare/screens/home_view/widgets/custom_app_bar.dart';
import 'package:unishare/screens/home_view/widgets/new_tools_list_view.dart';
import 'package:unishare/screens/home_view/widgets/recently_viewed_list_view.dart';
import 'package:unishare/screens/home_view/widgets/tools_title.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Column(
          children: [
            CustomAppBar(),
            SizedBox(height: 30),
            ToolsTitle(text: 'New Tools', route: ExploreView.id),
            SizedBox(height: 13),
            NewToolsListView(),
            SizedBox(height: 15),
            ToolsTitle(text: 'Recently viewed', route:ExploreRecentlyView.id),
            SizedBox(height: 10),
            RecentlyViewedListView(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
