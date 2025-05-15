import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';
import 'package:unishare/screens/login_view/model/user_model.dart';
import 'package:unishare/screens/update_profile/models/getting_image_model.dart';
import 'package:unishare/screens/update_profile/models/upload_image_model.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final LoginViewCubit loginViewCubit;
  UpdateProfileCubit({required this.loginViewCubit})
    : super(UpdateProfileInitial()) {}

  File? selectedImage;
  bool? isImageChanged = false;
  UploadImage uploadImage = UploadImage();
  GettingImage gettingImage = GettingImage();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController newFirstNameController = TextEditingController();
  TextEditingController newLastNameController = TextEditingController();
  TextEditingController newPhoneNumberController = TextEditingController();
  String? selectedLocation;

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
    if (FirebaseAuth.instance.currentUser != null) {
      await getProfilePicture(FirebaseAuth.instance.currentUser?.uid ?? '');
    }
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

  void clearingNewEmailTextField() {
    newEmailController.clear();
    emit(TextFieldCleared());
  }

  void clearingNewFirstNameTextField() {
    newFirstNameController.clear();
    emit(TextFieldCleared());
  }

  void clearingNewLastNameTextField() {
    newLastNameController.clear();
    emit(TextFieldCleared());
  }

  void clearingNewPhoneNumberTextField() {
    newPhoneNumberController.clear();
    emit(TextFieldCleared());
  }

  void clearingNewPasswordTextField() {
    newPasswordController.clear();
    emit(TextFieldCleared());
  }

  void clearingPasswordTextField() {
    currentPasswordController.clear();
    emit(TextFieldCleared());
  }

  void clearingConfirmNewPasswordTextField() {
    confirmNewPasswordController.clear();
    emit(TextFieldCleared());
  }

  String? validateNewEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your new email";
    } else if (!RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validateNewFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your first name";
    }
    return null;
  }

  String? validateNewLastName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your last name";
    }
    return null;
  }

  String? validateNewPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone number";
    }
    return null;
  }

  String? validateNewLocation(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your location";
    }
    return null;
  }

  void setLocation(String location) {
    selectedLocation = location;
  }

  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value != loginViewCubit.userModel?.password) {
      return "Incorrect Password";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter the same password";
    } else if (value != newPasswordController.text) {
      return "Passwords does not match";
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your new password';
    }
    return null;
  }

  void changeEmail({
    required String currentPassword,
    required String newEmail,
  }) async {
    emit(ChangingEmailLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);
        await user.verifyBeforeUpdateEmail(newEmail);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'pendingEmail': newEmail});
        //pending email de msh htb2a el email 8er lma tb2a == authenticated email y3ny user 3ml verify we email el adem et8yr lel gded fa b2a zy pending email yb2a pending email yro7 lel email
        emit(ChangingEmailSuccess());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        emit(ChangingEmailFailed(messege: 'Recent authentication required'));
      } else if (e.code == 'wrong-password') {
        emit(ChangingEmailFailed(messege: 'Incorrect password provided'));
      } else if (e.code == 'invalid-email') {
        emit(ChangingEmailFailed(messege: 'Invalid new email format'));
      } else if (e.code == 'email-already-in-use') {
        emit(ChangingEmailFailed(messege: 'This email already exists'));
      } else {
        emit(
          ChangingEmailFailed(
            messege: 'Firebase error: ${e.code} - ${e.message}',
          ),
        );
      }
    } catch (e) {
      emit(
        ChangingEmailFailed(
          messege: 'Couldnt Change Email Please Try Again Later',
        ),
      );
    }
  }

  void checkingIfUserVerifiedHisNewEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        final pendingEmail = data['pendingEmail'];
        // lma ywsl hna we yb2a mfesh pending email yb2a pending email htb2a null bs lw user 7awl y8yr el email s3tha fe pending email field gded hyege gwah el email ely mstny yt3mlo verify
        final currentAuthEmail = user.email;

        if (pendingEmail != null && currentAuthEmail == pendingEmail) {
          //1) lw pedning email da msh bnull fa hwa f3ln mwgod fe database fa fe email mstny yt3ml verify
          //2)7lten
          //! lw user m3mlsh verify yb2a el currentAuthEmail hyb2a nfs el email el adem fa hwa msh hyb2a zy el pending email ely hwa el email el gded ely lazm yt3mlo verify fa beltaly msh hy8yr el email lsa
          //! lw user 3ml verify yb2a el currentAuthEmail hyb2a el email el gded ely hwa mwgod f3ln fe pending email fa s3tha y8yr email el user el adem lel pending email 3shan user 3ml verify we el email bta3o elf3ly et8yr

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
                'email': pendingEmail,
                'pendingEmail': FieldValue.delete(),
                //hyshel el pending email 3shan khlas et3mlo verify we b2a email el user el f3ly flazm yb2a null 3shan b3den ama 2agy ackeck 3la if condition tany tb2a pending user de be null fa my8yrsh email tany
              });
        }
      }
    }
  }

  void changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ChangingPasswordLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'password': newPassword});

        emit(ChangingPasswordSuccess());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        emit(ChangingPasswordFailed(messege: 'Recent authentication required'));
      } else if (e.code == 'wrong-password') {
        emit(ChangingPasswordFailed(messege: 'Incorrect password provided'));
      } else if (e.code == 'weak-password') {
        emit(ChangingPasswordFailed(messege: 'Weak password'));
      } else {
        emit(
          ChangingPasswordFailed(
            messege: 'Firebase error: ${e.code} - ${e.message}',
          ),
        );
      }
    } catch (e) {
      emit(
        ChangingPasswordFailed(
          messege: 'Couldnt Change Password Please Try Again Later',
        ),
      );
    }
  }

  void changefName({required String fName, required String password}) async {
    emit(ChangingfNameLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'firstName': fName});
        await loginViewCubit.getUserData();
        final userBox = Hive.box<UserModel>('userBox');
        if (loginViewCubit.userModel != null) {
          userBox.put('user', loginViewCubit.userModel!);
        }

        emit(ChangingfNameSuccess());
      }
    } catch (e) {
      emit(ChangingfNameFailed());
    }
  }

  void changelName({required String lName, required String password}) async {
    emit(ChanginglNameLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'lastName': lName});
        await loginViewCubit.getUserData();
        final userBox = Hive.box<UserModel>('userBox');
        if (loginViewCubit.userModel != null) {
          userBox.put('user', loginViewCubit.userModel!);
        }

        emit(ChanginglNameSuccess());
      }
    } catch (e) {
      emit(ChanginglNameFailed());
    }
  }

  void changePhoneNumber({
    required String pNumber,
    required String password,
  }) async {
    emit(ChangingPhoneNumberLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'phone': pNumber});
        await loginViewCubit.getUserData();
        final userBox = Hive.box<UserModel>('userBox');
        if (loginViewCubit.userModel != null) {
          userBox.put('user', loginViewCubit.userModel!);
        }

        emit(ChangingPhoneNumberSuccess());
      }
    } catch (e) {
      emit(ChangingPhoneNumberFailed());
    }
  }

  void changeLocation({
    required String location,
    required String password,
  }) async {
    emit(ChangingLocationLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'location': location});
        await loginViewCubit.getUserData();
        final userBox = Hive.box<UserModel>('userBox');
        if (loginViewCubit.userModel != null) {
          userBox.put('user', loginViewCubit.userModel!);
        }

        emit(ChangingLocationSuccess());
      }
    } catch (e) {
      emit(ChangingLocationFailed());
    }
  }
}
