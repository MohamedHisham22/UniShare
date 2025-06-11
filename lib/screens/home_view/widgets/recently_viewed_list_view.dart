import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/home_view/cubit/cubit/recently_viewed_cubit.dart';
import 'package:unishare/screens/home_view/models/recently_view_model/recently_view_model.dart';
import 'package:unishare/screens/home_view/widgets/recently_viewed.dart';

class RecentlyViewedListView extends StatelessWidget {
  const RecentlyViewedListView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final userID = FirebaseAuth.instance.currentUser?.uid ?? '';

    return SizedBox(
      height: height * 0.3,
      child: BlocBuilder<RecentlyViewedCubit, RecentlyViewedState>(
        builder: (context, state) {
          // Load recently viewed when widget builds
          if (userID.isNotEmpty && state is! RecentlyCubitSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<RecentlyViewedCubit>().recentlyView(userID);
            });
          }

          if (state is RecentlyCubitLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RecentlyCubitErorr) {
            return Center(child: Text("Error: ${state.error}"));
          } else if (state is RecentlyCubitSuccess) {
            final filteredItems =
                state.recentlyItems
                    .where(
                      (recentlyItems) => recentlyItems.createdUserId != userID,
                    )
                    .toList();
            if (filteredItems.isEmpty) {
              return const Center(child: Text("No recently viewed items yet."));
            }
            return ListView.separated(
              itemBuilder: (c, i) {
                RecentlyViewModel item = filteredItems[i];
                return RecentlyViewed(item: item);
              },
              separatorBuilder: (c, i) => SizedBox(width: 17),
              itemCount: filteredItems.length,
              scrollDirection: Axis.horizontal,
            );
          }
          return const Center(child: Text("No data available."));
        },
      ),
    );
  }
}
