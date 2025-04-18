import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';
import 'package:unishare/screens/listing_view/cubit/my_listing_cubit.dart';
import 'package:unishare/screens/main_view/views/main_view.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddItemsCubit, AddItemsState>(
      listener: (context, state) {
        final cubit = context.read<AddItemsCubit>();
        if (state is AddItemsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                cubit.isEditing
                    ? 'Item updated successfully!'
                    : 'Item added successfully!',
              ),
              backgroundColor: Colors.green,
            ),
          );
          final myListingCubit = context.read<MyListingCubit>();
          myListingCubit.getItems(FirebaseAuth.instance.currentUser?.uid);
          context.read<AddItemsCubit>().clearFields();
          Navigator.pushNamed(context, MainView.id);
        } else if (state is AddItemsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please fill all fields'),
              backgroundColor: Colors.red,
            ),
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
                        cubit.isEditing ? 'Edit Item' : 'Add Item',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
            ),
          ),
        );
      },
    );
  }
}
