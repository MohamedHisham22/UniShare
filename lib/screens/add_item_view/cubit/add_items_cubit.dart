import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_items_state.dart';

class AddItemsCubit extends Cubit<AddItemsState> {
  String selectedOption = 'Donate';
  AddItemsCubit() : super(AddItemsInitial());

  void onOptionSelected(String value) {
    selectedOption = value;
    emit(AddItemsOnOptionSelected());
  }

  File? selectedImage; // lw h3rd image w7da
  List<File> imagesList = [];
  //lw 3ayz a3rd kza image yb2a lazm a7ot kol selected image fe el list

  // String? _selectedImagename; //lw h7tag azhr esm el image
  void getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final XFile? imageGallery = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageGallery != null) {
      selectedImage = File(imageGallery.path);
      imagesList.add(selectedImage!);
      //b7ot el selected image fe el list 3shad a3rd el list be kol el selcted images
      // _selectedImagename = imageGallery.name; //lw 3ayz atl3 esm el image
      // imageController.text = _selectedImagename!; //lw 3ayz azhr esm el image
    }
    emit(ImagePicked());
  }

  void getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageCamera = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (imageCamera != null) {
      selectedImage = File(imageCamera.path);
      imagesList.add(selectedImage!);
    }
    emit(ImagePicked());
  }

  void removeImageFromImageList(int index) {
    imagesList.removeAt(index);
    emit(ImageRemoved());
  }
}
