import 'package:flutter/material.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';

class UploadImageFromCamera extends StatelessWidget {
  const UploadImageFromCamera({super.key, required this.cubit});

  final AddItemsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cubit.getImageFromCamera,
      child: Container(
        width: 70,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xff062D58),
        ),
        child: Center(
          child: Icon(Icons.camera_alt_outlined, color: Colors.white),
        ),
      ),
    );
  }
}
