import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/add_item_view/models/add_item_model.dart';
import 'package:unishare/screens/home_view/cubit/get_items_cubit.dart';

part 'add_items_state.dart';

class AddItemsCubit extends Cubit<AddItemsState> {
  final GetItemsCubit getItemsCubit;

  AddItemsCubit({required this.getItemsCubit}) : super(AddItemsInitial());
  String selectedOption = 'Donate';
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController optionsController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<AddItemModel> itemsList = [];

  Future<void> addItem(String userID) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(AddItemsLoading());

    try {
      final formData = FormData.fromMap({
        'itemName': itemNameController.text,
        'itemDescription': descriptionController.text,
        'itemPrice':
            selectedOption == 'Donate' ? 0 : int.parse(priceController.text),
        'itemYear': DateTime.now().year,
        'itemBrand': 'BrandName',
        'userId': userID,
        'ItemCondition': conditionController.text,
        'ListingOption': optionsController.text,
        'ItemDuration': durationController.text,
      });

      if (selectedImage != null) {
        formData.files.add(
          MapEntry(
            'ImageFile',
            await MultipartFile.fromFile(selectedImage!.path),
          ),
        );
      }

      final response = await DioHelper.postData(
        path: 'items',
        body: formData,
        isFormData: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await getItemsCubit.getItems();
        emit(AddItemsSuccess());
      } else {
        emit(AddItemsError("Failed to add item"));
      }
    } catch (e) {
      emit(AddItemsError(e.toString()));
    }
  }

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
