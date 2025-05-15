part of 'update_profile_cubit.dart';

@immutable
sealed class UpdateProfileState {}

final class UpdateProfileInitial extends UpdateProfileState {}

class ImagePicked extends UpdateProfileState {}

class ProfilePicUpdateCanceled extends UpdateProfileState {
  final String messege = 'Updating Profile Picture Canceled';
}

class UpdatingImageLoading extends UpdateProfileState {}

class UpdatingImageSuccess extends UpdateProfileState {
  final String messege = 'Profile Picture Changed Successfully';
}

class UpdatingImageFailed extends UpdateProfileState {
  final String messege = 'Couldnt Change Profile Image Please Try Again Later';
}

class GettingProfileImageLoading extends UpdateProfileState {}

class GettingProfileImageSuccess extends UpdateProfileState {}

class GettingProfileImageFailed extends UpdateProfileState {}

class DeletingProfileImageLoading extends UpdateProfileState {}

class DeletingProfileImageSuccess extends UpdateProfileState {
  final String messege = 'Profile Picture Deleted Successfully';
}

class DeletingProfileImageFailed extends UpdateProfileState {
  final String messege =
      'Couldnt Delete Profile Picture Please Try Again Later';
}

class ChangingPasswordLoading extends UpdateProfileState {}

class ChangingPasswordSuccess extends UpdateProfileState {}

class ChangingPasswordFailed extends UpdateProfileState {
  String messege;
  ChangingPasswordFailed({required this.messege});
}

class ChangingEmailLoading extends UpdateProfileState {}

class ChangingEmailSuccess extends UpdateProfileState {}

class ChangingEmailFailed extends UpdateProfileState {
  String messege;
  ChangingEmailFailed({required this.messege});
}

class TextFieldCleared extends UpdateProfileState {}

class ChangingfNameLoading extends UpdateProfileState {}

class ChangingfNameSuccess extends UpdateProfileState {}

class ChangingfNameFailed extends UpdateProfileState {
  final String messege = 'Couldnt Chnage First Name Please Try Again Late';
}

class ChanginglNameLoading extends UpdateProfileState {}

class ChanginglNameSuccess extends UpdateProfileState {}

class ChanginglNameFailed extends UpdateProfileState {
  final String messege = 'Couldnt Chnage Last Name Please Try Again Late';
}

class ChangingPhoneNumberLoading extends UpdateProfileState {}

class ChangingPhoneNumberSuccess extends UpdateProfileState {}

class ChangingPhoneNumberFailed extends UpdateProfileState {
  final String messege = 'Couldnt Chnage Phone Number Please Try Again Late';
}

class ChangingLocationLoading extends UpdateProfileState {}

class ChangingLocationSuccess extends UpdateProfileState {}

class ChangingLocationFailed extends UpdateProfileState {
  final String messege = 'Couldnt Chnage Your Location Please Try Again Late';
}
