part of 'signup_view_cubit.dart';

@immutable
sealed class SignupViewState {}

final class SignupViewInitial extends SignupViewState {}

final class SignupLoading extends SignupViewState {}

final class SignupSuccess extends SignupViewState {}

final class SignupFailed extends SignupViewState {
  String errorMessage;
  SignupFailed({required this.errorMessage});
}

final class ClearedFields extends SignupViewState {}
