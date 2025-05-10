import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/explore_recently_view/cubit/search_explore_recently_view_cubit.dart';
import 'package:unishare/screens/explore_recently_view/widgets/explore_recently_tools.dart';

class SearchExploreRecentlyListView extends StatelessWidget {
  const SearchExploreRecentlyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchExploreRecentlyViewCubit, SearchExploreRecentlyViewState>(
      builder: (context, state) {
        if (state is SearchExploreRecentlyViewLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchExploreRecentlyViewSuccess) {
          final items = context.read<SearchExploreRecentlyViewCubit>().recentlyList;
          if (items.isEmpty) {
            return const Center(child: Text("No items found."));
          }
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ExploreRecentlyTools(recentlyItem: items[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          );
        } else if (state is SearchExploreRecentlyViewErorr) {
          return const Center(child: Text("Error occurred while searching."));
        }
        return const SizedBox();
      },
    );
  }
}