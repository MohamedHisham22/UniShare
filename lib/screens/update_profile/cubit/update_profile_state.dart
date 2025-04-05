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
