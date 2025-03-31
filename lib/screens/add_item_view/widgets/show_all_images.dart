import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';
import 'package:unishare/screens/add_item_view/widgets/images_list_view.dart';

class ShowAllImages extends StatelessWidget {
  const ShowAllImages({super.key, required this.cubit});

  final AddItemsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: double.infinity,
        height: 140,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xffEAEAEA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ImagesListView(cubit: cubit),
      ),
    );
  }
}
