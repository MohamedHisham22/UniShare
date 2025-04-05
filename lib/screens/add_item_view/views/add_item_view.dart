import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';
import 'package:unishare/screens/add_item_view/widgets/add_item_button.dart';
import 'package:unishare/screens/add_item_view/widgets/add_item_view_body.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({super.key});
  static String id = '/addItem';
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddItemsCubit>();
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 85,
      //   title: Text(
      //     'Add item',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 30,
      //       color: kPrimaryColor,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: AddItemViewBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: AddItemButton(),
      ),
    );
  }
}
