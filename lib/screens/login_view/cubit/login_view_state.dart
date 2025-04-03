part of 'login_view_cubit.dart';

@immutable
sealed class LoginViewState {}

final class LoginViewInitial extends LoginViewState {}

final class LoginLoading extends LoginViewState {}

final class LoginSuccess extends LoginViewState {}

final class LoginFailed extends LoginViewState {
  String errorMessage;
  LoginFailed({required this.errorMessage});
}

final class SigningOutLoading extends LoginViewState {}

final class SigningOutSuccess extends LoginViewState {}

final class SigningOutFailed extends LoginViewState {
  String errorMessage;
  SigningOutFailed({required this.errorMessage});
}

final class GettingDataSuccess extends LoginViewState {}
