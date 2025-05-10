import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/explore_view/cubit/search_cubit.dart';
import 'package:unishare/screens/explore_view/widgets/explore_tools.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchSuccess) {
          final items = context.read<SearchCubit>().itemsList;
          if (items.isEmpty) {
            return const Center(child: Text("No items found."));
          }
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ExploreTools(item: items[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          );
        } else if (state is SearchErorr) {
          return const Center(child: Text("Error occurred while searching."));
        }
        return const SizedBox(); // Show nothing initially
      },
    );
  }
}
