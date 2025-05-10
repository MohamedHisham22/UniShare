import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/explore_view/widgets/back_botton.dart';
import 'package:unishare/screens/explore_view/widgets/explore_tools_list_view.dart';
import 'package:unishare/screens/explore_view/widgets/custom_text_field.dart';
import 'package:unishare/screens/explore_view/widgets/search_result_list_view.dart';
import 'package:unishare/screens/explore_view/cubit/search_cubit.dart';

class ExploreViewBody extends StatelessWidget {
  const ExploreViewBody({super.key});

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
                  child: const BackBotton(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const CustomTextField(),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  final searchCubit = context.read<SearchCubit>();
                  final query = searchCubit.currentSearch;

                  if (query.isNotEmpty) {
                    if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SearchSuccess) {
                      if (searchCubit.itemsList.isEmpty) {
                        return const Center(child: Text('No Results'));
                      } else {
                        return const SearchResultListView();
                      }
                    } else if (state is SearchErorr) {
                      return const Center(child: Text('Erorr'));
                    }
                  }

                  return const ExploreToolsListView();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
