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
  bool isEditing = false;
  String? editingItemId;
  List<String> oldImagesUrls = [];
  String? imageUrl;

  AddItemsCubit({required this.getItemsCubit}) : super(AddItemsInitial());

  String selectedOption = 'Donate';
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController optionsController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  List<AddItemModel> itemsList = [];

  void clearFields() {
    itemNameController.clear();
    descriptionController.clear();
    priceController.clear();
    selectedImage = null;
    optionsController.text = 'Donate';
    imagesList.clear();
    oldImagesUrls.clear();
    selectedOption = 'Donate';
    isEditing = false;
    emit(AddItemsClearFields());
  }

Future<void> addItem(String userID) async {
  emit(AddItemsLoading());

  try {
    final wasEditing = isEditing;
    final formData = FormData.fromMap({
      'itemName': itemNameController.text,
      'itemDescription': descriptionController.text,
      'itemPrice':
          selectedOption == 'Donate' ? 0 : int.parse(priceController.text),
      'itemYear': DateTime.now().year,
      'itemBrand': categoryController.text,
      'userId': userID,
      'ItemCondition': conditionController.text,
      'ListingOption': optionsController.text,
      'ItemDuration': durationController.text,
    });

    // Add old images (including the cover image as the first one)
    for (int i = 0; i < oldImagesUrls.length; i++) {
      final imageUrl = oldImagesUrls[i];
      try {
        final response = await Dio().get<List<int>>(
          imageUrl,
          options: Options(responseType: ResponseType.bytes),
        );

        final tempDir = Directory.systemTemp;
        final tempFile = await File('${tempDir.path}/image_$i.jpg').create();
        await tempFile.writeAsBytes(response.data!);

        formData.files.add(
          MapEntry(
            'AdditionalImageFiles',
            await MultipartFile.fromFile(
              tempFile.path,
              filename: 'old_image_$i.jpg',
            ),
          ),
        );
      } catch (e) {
        print("Error $imageUrl - ${e.toString()}");
      }
    }

    // Add new images
    for (int i = 0; i < imagesList.length; i++) {
      formData.files.add(
        MapEntry(
          'AdditionalImageFiles',
          await MultipartFile.fromFile(imagesList[i].path),
        ),
      );
    }

    // Set the first image as the cover image (imageFile)
    if (oldImagesUrls.isNotEmpty) {
      // Use the first old image as cover
      final firstImageUrl = oldImagesUrls[0];
      final response = await Dio().get<List<int>>(
        firstImageUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      final tempDir = Directory.systemTemp;
      final tempFile = await File('${tempDir.path}/cover_image.jpg').create();
      await tempFile.writeAsBytes(response.data!);
      formData.files.add(
        MapEntry(
          'imageFile',
          await MultipartFile.fromFile(tempFile.path),
        ),
      );
    } else if (imagesList.isNotEmpty) {
      // Use the first new image as cover
      formData.files.add(
        MapEntry(
          'imageFile',
          await MultipartFile.fromFile(imagesList[0].path),
        ),
      );
    }

    Response response;
    if (isEditing && editingItemId != null) {
      response = await DioHelper.putFormData(
        path: 'items/$editingItemId',
        body: formData,
      );
    } else {
      response = await DioHelper.postData(
        path: 'items',
        body: formData,
        isFormData: true,
      );
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      await getItemsCubit.getItems();
      isEditing = false;
      editingItemId = null;
      emit(AddItemsSuccess(wasEditing));
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

  File? selectedImage;
  List<dynamic> imagesList = [];

  void getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageGallery = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageGallery != null) {
      selectedImage = File(imageGallery.path);
      imagesList.add(selectedImage!);
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

  void removeOldImage(int index) {
    final removedImage = oldImagesUrls[index];
    oldImagesUrls.removeAt(index);

    if (index == 0 || removedImage == imageUrl) {
      if (oldImagesUrls.isNotEmpty) {
        imageUrl = oldImagesUrls.first;
      } else if (imagesList.isNotEmpty) {
        imageUrl = null;
        selectedImage = imagesList.first;
      } else {
        imageUrl = null;
        selectedImage = null;
      }
    }

    emit(ImageRemoved());
  }

 void populateFieldsForEditing(dynamic item) {
  isEditing = true;
  editingItemId = item.itemId;

  itemNameController.text = item.itemName ?? '';
  descriptionController.text = item.itemDescription ?? '';
  priceController.text = item.itemPrice?.toString() ?? '';
  conditionController.text = item.itemCondition ?? '';
  durationController.text = item.itemDuration ?? '';
  categoryController.text = item.itemBrand ?? '';

  // Clear old images and add new ones
  oldImagesUrls.clear();
  
  // Add the cover image (imageUrl) as the first image
  if (item.imageUrl != null && item.imageUrl!.isNotEmpty) {
    oldImagesUrls.add(item.imageUrl!);
  }
  
  // Add additional images
  oldImagesUrls.addAll(item.additionalImageUrls ?? []);

  // Clear new images (optional)
  imagesList.clear();

  final allowedOptions = ['Donate', 'Sell', 'Rent'];
  if (item.itemPrice != null && item.itemPrice != 0) {
    if (item.itemDuration != null) {
      optionsController.text = 'Rent';
      selectedOption = 'Rent';
    } else {
      optionsController.text = 'Sell';
      selectedOption = 'Sell';
    }
  } else {
    final value = item.listingOption ?? 'Donate';
    if (allowedOptions.contains(value)) {
      optionsController.text = value;
      selectedOption = value;
    } else {
      optionsController.text = 'Donate';
      selectedOption = 'Donate';
    }
  }

  emit(AddItemsFieldsPopulated());
}
}
