import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/home_view/cubit/get_items_cubit.dart';
import 'package:unishare/screens/home_view/models/get_items_model/get_items_model.dart';
import 'package:unishare/screens/home_view/widgets/new_tools.dart';

class NewToolsListView extends StatelessWidget {
  const NewToolsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final currentUserUid = FirebaseAuth.instance.currentUser?.uid;

    return SizedBox(
      height: height * 0.37,
      child: BlocBuilder<GetItemsCubit, GetItemsCubitState>(
        builder: (context, state) {
          if (state is GetItemsCubitLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetItemsCubitError) {
            return Center(child: Text("No items available."));
          } else if (state is GetItemsCubitSuccess) {
            final filteredItems =
                state.items
                    .where((item) => item.userId != currentUserUid)
                    .toList();

            if (filteredItems.isEmpty) {
              return const Center(child: Text("No items available."));
            }

            return ListView.separated(
              itemBuilder: (c, i) {
                GetItemsModel item = filteredItems[i];
                return NewTools(item: item);
              },
              separatorBuilder: (c, i) => SizedBox(width: 0),
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
