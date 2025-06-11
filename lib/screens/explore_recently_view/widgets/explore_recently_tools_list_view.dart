import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/explore_recently_view/widgets/explore_recently_tools.dart';
import 'package:unishare/screens/home_view/cubit/cubit/recently_viewed_cubit.dart';
import 'package:unishare/screens/home_view/models/recently_view_model/recently_view_model.dart';

class ExploreRecentlyToolsListView extends StatelessWidget {
  const ExploreRecentlyToolsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    return BlocBuilder<RecentlyViewedCubit, RecentlyViewedState>(
      builder: (context, state) {
        if (state is RecentlyCubitLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RecentlyCubitErorr) {
          return Center(child: Text("Error: ${state.error}"));
        } else if (state is RecentlyCubitSuccess) {
          final filteredItems =
              state.recentlyItems
                  .where((item) => item.createdUserId != currentUserUid)
                  .toList();
          if (filteredItems.isEmpty) {
            return const Center(child: Text("No items available."));
          }
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c, i) {
              RecentlyViewModel item = filteredItems[i];
              return ExploreRecentlyTools(recentlyItem: item);
            },
            separatorBuilder: (c, i) => SizedBox(height: 10),
            itemCount: filteredItems.length,
          );
        }
        return const Center(child: Text("No data available."));
      },
    );
  }
}
