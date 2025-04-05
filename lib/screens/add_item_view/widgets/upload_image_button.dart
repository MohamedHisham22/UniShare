import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';
import 'package:unishare/screens/add_item_view/widgets/show_all_images.dart';
import 'package:unishare/screens/add_item_view/widgets/upload_from_gallery_button.dart';
import 'package:unishare/screens/add_item_view/widgets/upload_image_button_from_camera.dart';

class UploadingImage extends StatelessWidget {
  const UploadingImage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddItemsCubit>();

    return Column(
      children: [
        Row(
          children: [
            UploadImageFromGallery(cubit: cubit),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Or',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            UploadImageFromCamera(cubit: cubit),
          ],
        ),
        if (cubit.imagesList.isNotEmpty) ShowAllImages(cubit: cubit),
        if (cubit.imagesList.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Text(
                  'Please upload at least one image.',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
