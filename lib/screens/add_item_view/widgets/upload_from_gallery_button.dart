import 'package:flutter/material.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';

class UploadImageFromGallery extends StatelessWidget {
  const UploadImageFromGallery({super.key, required this.cubit});

  final AddItemsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cubit.getImageFromGallery,
      child: Container(
        width: 250,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xff062D58),
        ),
        child: Center(
          child: Text(
            'Choose Image From Gallery',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
