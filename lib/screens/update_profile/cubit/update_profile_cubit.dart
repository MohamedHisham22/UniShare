import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/update_profile/models/upload_image_model.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  File? selectedImage;
  bool? isImageChanged = false;
  UploadImage uploadImage = UploadImage();

  void updateProfilePicture() async {
    final ImagePicker picker = ImagePicker();

    final XFile? imageGallery = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageGallery != null) {
      selectedImage = File(imageGallery.path);
      isImageChanged = true;
    } else {
      isImageChanged = false;
    }

    emit(ImagePicked());
  }

  void cancelUpdatingProfilePicture() {
    isImageChanged = false;
    selectedImage = null;
    emit(ProfilePicUpdateCanceled());
  }

  void submitingProfilePictureChangesToDataBase(File profileImage) async {
    emit(Loading());
    try {
      FormData formData = FormData.fromMap({
        'ProfileImage': await MultipartFile.fromFile(profileImage.path),
      });
      final response = await DioHelper.putFormData(
        path: 'users/1test',
        body: formData,
      );
      uploadImage = UploadImage.fromJson(response.data);
      if (response.statusCode == 200) {
        emit(UpdatingImageSuccess());
        isImageChanged = false;
      } else {
        emit(UpdatingImageFailed());
      }
    } catch (e) {
      emit(UpdatingImageFailed());
    }
  }
}
