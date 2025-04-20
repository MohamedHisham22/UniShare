import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/listing_view/cubit/my_listing_cubit.dart';
import 'package:unishare/screens/listing_view/models/my_listing_model/my_listing_model.dart';
import 'package:unishare/screens/listing_view/widgets/listing_tools_details.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';
import 'package:unishare/screens/tool_details_view_user/views/tool_details_view_user.dart';

class ListingToolsListView extends StatelessWidget {
  const ListingToolsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemDetailesCubit = context.read<ToolDetailesClientViewCubit>();
    String userID = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Expanded(
      child: BlocBuilder<MyListingCubit, MyListingState>(
        builder: (context, state) {
          if (state is MyListingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MyListingErorr) {
            return Center(child: Text("No items available."));
          } else if (state is MyListingSuccess) {
            if (state.listing.isEmpty) {
              return const Center(child: Text("No items available."));
            }

            return ListView.separated(
              itemBuilder: (c, i) {
                MyListingModel item = state.listing[i];
                return GestureDetector(
                  onTap: () async {
                    await itemDetailesCubit.showItemDetailes(
                      itemID: item.itemId!,
                      userID: userID,
                    );
                    Navigator.pushNamed(context, ToolDetailsViewUser.id);
                  },
                  child: ListingToolsDetails(item: item),
                );
              },
              separatorBuilder: (c, i) => const SizedBox(height: 10),
              itemCount: state.listing.length,
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
