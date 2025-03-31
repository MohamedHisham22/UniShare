import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';
import 'package:unishare/screens/add_item_view/widgets/full_screen_file_image_view.dart';

class ImagesListView extends StatelessWidget {
  const ImagesListView({super.key, required this.cubit});

  final AddItemsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(width: 10),
      itemCount: cubit.imagesList.length,
      itemBuilder:
          (context, index) => Padding(
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
                              imagePath: cubit.imagesList[index],
                            ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      height: 100,
                      width: 100,
                      cubit.imagesList[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 4),
                  child: GestureDetector(
                    onTap: () {
                      cubit.removeImageFromImageList(index);
                    },
                    child: Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
