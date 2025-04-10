import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/saved_view/cubit/favorite_items_cubit_cubit.dart';
import 'package:unishare/screens/saved_view/widgets/saved_tools.dart';

class SavedToolsListView extends StatelessWidget {
  const SavedToolsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoriteItemsCubit>();
    return Expanded(
      child: ListView.separated(
        itemBuilder: (c, i) {
          final item = cubit.favoritItems[i];
          return SavedTools(item: item);
        },
        separatorBuilder: (c, i) => SizedBox(height: 10),
        itemCount: cubit.favoritItems.length,
      ),
    );
  }
}
