import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/explore_recently_view/cubit/search_explore_recently_view_cubit.dart';
import 'package:unishare/screens/explore_recently_view/widgets/explore_recently_tools_list_view.dart';
import 'package:unishare/screens/explore_recently_view/widgets/search_explore_recently_list_view.dart';
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
          const SizedBox(height: 20),
          const SearchRecentlyView(),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<
                SearchExploreRecentlyViewCubit,
                SearchExploreRecentlyViewState
              >(
                builder: (context, state) {
                  final searchCubit =
                      context.read<SearchExploreRecentlyViewCubit>();
                  final query = searchCubit.currentSearch;

                  if (query.isNotEmpty) {
                    if (state is SearchExploreRecentlyViewLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SearchExploreRecentlyViewSuccess) {
                      if (searchCubit.recentlyList.isEmpty) {
                        return const Center(child: Text('No Results'));
                      } else {
                        return const SearchExploreRecentlyListView();
                      }
                    } else if (state is SearchExploreRecentlyViewErorr) {
                      return const Center(child: Text('Erorr'));
                    }
                  }

                  return const ExploreRecentlyToolsListView();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
