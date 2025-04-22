import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';
import 'package:unishare/screens/add_item_view/widgets/full_screen_file_image_view.dart';

class ImagesListView extends StatelessWidget {
  const ImagesListView({super.key, required this.cubit});

  final AddItemsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final totalCount = cubit.oldImagesUrls.length + cubit.imagesList.length;

    return BlocBuilder<AddItemsCubit, AddItemsState>(
      builder: (context, state) {
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(width: 10),
          itemCount: totalCount,
          itemBuilder: (context, index) {
            final isOldImage = index < cubit.oldImagesUrls.length;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => FullScreenFileImageView(
                                imagePath:
                                    isOldImage
                                        ? cubit.oldImagesUrls[index]
                                        : cubit
                                            .imagesList[index -
                                                cubit.oldImagesUrls.length]
                                            .path,
                              ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child:
                          isOldImage
                              ? Image.network(
                                cubit.oldImagesUrls[index],
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                              : Image.file(
                                cubit.imagesList[index -
                                    cubit.oldImagesUrls.length],
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 4),
                    child: GestureDetector(
                      onTap: () {
                        if (isOldImage) {
                          cubit.removeOldImage(index);
                        } else {
                          cubit.removeImageFromImageList(
                            index - cubit.oldImagesUrls.length,
                          );
                        }
                      },
                      child: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
