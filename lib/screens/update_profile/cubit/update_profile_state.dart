part of 'update_profile_cubit.dart';

@immutable
sealed class UpdateProfileState {}

final class UpdateProfileInitial extends UpdateProfileState {}

class ImagePicked extends UpdateProfileState {}

class ProfilePicUpdateCanceled extends UpdateProfileState {
  final String messege = 'Updating Profile Picture Canceled';
}

class Loading extends UpdateProfileState {}

class UpdatingImageSuccess extends UpdateProfileState {}

class UpdatingImageFailed extends UpdateProfileState {
  final String messege = 'Please Try Again Later';
}
