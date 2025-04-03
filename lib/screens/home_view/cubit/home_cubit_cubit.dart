import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(HomeCubitInitial());

  File? selectedImage;
  void getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final XFile? imageGallery = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageGallery != null) {
      selectedImage = File(imageGallery.path);
      emit(ImagePicked());
    }
  }
}
