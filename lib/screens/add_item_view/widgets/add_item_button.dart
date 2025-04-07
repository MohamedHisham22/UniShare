import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';
import 'package:unishare/screens/listing_view/cubit/my_listing_cubit.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddItemsCubit, AddItemsState>(
      listener: (context, state) {
        if (state is AddItemsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Item added successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          final myListingCubit = context.read<MyListingCubit>();
          myListingCubit.getItems(FirebaseAuth.instance.currentUser?.uid);
          Navigator.pop(context);
        } else if (state is AddItemsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AddItemsCubit>();

        return GestureDetector(
          onTap: () {
            cubit.addItem(FirebaseAuth.instance.currentUser?.uid ?? '');
          },
          child: Container(
            width: 239,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: kPrimaryColor,
            ),
            child: Center(
              child:
                  state is AddItemsLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                        'Add Item',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
            ),
          ),
        );
      },
    );
  }
}
