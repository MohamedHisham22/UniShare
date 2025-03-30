import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/home_view/cubit/get_items_cubit.dart';
import 'package:unishare/screens/home_view/models/get_items_model/get_items_model.dart';
import 'package:unishare/screens/home_view/widgets/new_tools.dart';
import 'package:unishare/screens/tool_details_client_view/views/tool_details_view_client.dart';

class NewToolsListView extends StatelessWidget {
  const NewToolsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.3,
      child: BlocBuilder<GetItemsCubit, GetItemsCubitState>(
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
              itemBuilder: (c, i) {
                GetItemsModel item = state.items[i];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ToolDetailsViewClient.id);
                  },
                  child: NewTools(item: item),
                );
              },
              separatorBuilder: (c, i) => SizedBox(width: 17),
              itemCount: state.items.length,
              scrollDirection: Axis.horizontal,
            );
          }
          return const Center(child: Text("No data available."));
        },
      ),
    );
  }
}
