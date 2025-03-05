import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/explore_view/widgets/explore_tools.dart';
import 'package:unishare/screens/home_view/cubit/get_items_cubit.dart';
import 'package:unishare/screens/home_view/models/get_items_model/get_items_model.dart';

class ExploreToolsListView extends StatelessWidget {
  const ExploreToolsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetItemsCubit, GetItemsCubitState>(
      builder: (context, state) {
        if (state is GetItemsCubitLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetItemsCubitError) {
          return Center(child: Text("Error: ${state.error}"));
        } else if (state is GetItemsCubitSuccess) {
          if (state.items.isEmpty) {
            return const Center(child: Text("No items available."));
          }
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c, i) {
              GetItemsModel item = state.items[i];
              return ExploreTools(item: item);
            },
            separatorBuilder: (c, i) => SizedBox(height: 10),
            itemCount: state.items.length,
          );
        }
        return const Center(child: Text("No data available."));
      },
    );
  }
}
