import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          border: Border.all(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Color(0xffEAEAEA),
          ),
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Color(0xffEAEAEA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: BlocBuilder<AddItemsCubit, AddItemsState>(
          builder: (context, state) {
            return ImagesListView(cubit: cubit);
          },
        ),
      ),
    );
  }
}
