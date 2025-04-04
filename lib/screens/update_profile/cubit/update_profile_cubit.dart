import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/update_profile/models/getting_image_model.dart';
import 'package:unishare/screens/update_profile/models/upload_image_model.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial()) {}

  File? selectedImage;
  bool? isImageChanged = false;
  UploadImage uploadImage = UploadImage();
  GettingImage gettingImage = GettingImage();

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

  void submitingProfilePictureChangesToDataBase(
    File profileImage,
    String userID,
  ) async {
    emit(UpdatingImageLoading());
    try {
      FormData formData = FormData.fromMap({
        'ProfileImage': await MultipartFile.fromFile(profileImage.path),
      });
      final response = await DioHelper.putFormData(
        path: 'users/$userID',
        body: formData,
      );
      uploadImage = UploadImage.fromJson(response.data);
      if (response.statusCode == 200) {
        await getProfilePicture(FirebaseAuth.instance.currentUser?.uid ?? '');
        isImageChanged = false;
        selectedImage = null;
        emit(UpdatingImageSuccess());
      } else {
        emit(UpdatingImageFailed());
      }
    } catch (e) {
      emit(UpdatingImageFailed());
    }
  }

  Future<void> getProfilePicture(String userID) async {
    emit(GettingProfileImageLoading());
    try {
      final response = await DioHelper.getData(path: 'users/$userID');
      gettingImage = GettingImage.fromJson(response.data);
      if (response.statusCode == 200) {
        emit(GettingProfileImageSuccess());
        isImageChanged = false;
        selectedImage = null;
      } else {
        emit(GettingProfileImageFailed());
      }
    } catch (e) {
      emit(GettingProfileImageFailed());
    }
  }

  void startAppWithProfileImage() async {
    await getProfilePicture(FirebaseAuth.instance.currentUser?.uid ?? '');
  }

  void deleteProfilePicture({required String userID}) async {
    emit(DeletingProfileImageLoading());
    try {
      final response = await DioHelper.deleteData(
        path: 'users/$userID/profile-image',
      );
      if (response.statusCode == 200) {
        await getProfilePicture(FirebaseAuth.instance.currentUser?.uid ?? '');
        emit(DeletingProfileImageSuccess());
      } else {
        emit(DeletingProfileImageFailed());
      }
    } catch (e) {
      emit(DeletingProfileImageFailed());
    }
  }
}
