import 'package:flutter/material.dart';
import 'package:unishare/refresh_app.dart';
import 'package:unishare/screens/explore_view/widgets/explore_view_body.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});
  static String id = '/explore';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          RefreshApp.restartApp(context);
        },
        child: ExploreViewBody(),
      ),
    );
  }
}
