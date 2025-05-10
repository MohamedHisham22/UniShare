import 'package:flutter/material.dart';
import 'package:unishare/refresh_app.dart';
import 'package:unishare/screens/explore_recently_view/widgets/explore_recently_view_body.dart';

class ExploreRecentlyView extends StatelessWidget {
  const ExploreRecentlyView({super.key});
static String id = '/exploreRecentlyView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          RefreshApp.restartApp(context);
        },
        child: ExploreRecentlyViewBody(),
      ),
    );
  }
}