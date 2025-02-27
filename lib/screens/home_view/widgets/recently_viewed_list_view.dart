import 'package:flutter/cupertino.dart';
import 'package:unishare/screens/home_view/widgets/recently_viewed.dart';

class RecentlyViewedListView extends StatelessWidget {
  const RecentlyViewedListView({super.key});

  @override
  Widget build(BuildContext context) {
        final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.3,
      child: ListView.separated(
        itemBuilder: (c, i) => RecentlyViewed(),
        separatorBuilder: (c, i) => SizedBox(width: 17),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
