import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/saved_view/cubit/favorite_items_cubit_cubit.dart';
import 'package:unishare/screens/saved_view/widgets/saved_tools_list_view.dart';

class SavedViewBody extends StatelessWidget {
  const SavedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoriteItemsCubit>();
    return BlocBuilder<FavoriteItemsCubit, FavoriteItemsState>(
      builder: (context, state) {
        if (cubit.favoritItems.isEmpty) {
          return Center(
            child: Text(
              'No Favorite Items Added Yet',
              style: TextStyle(fontSize: 18),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
            child: Column(children: [SavedToolsListView()]),
          );
        }
      },
    );
  }
}
