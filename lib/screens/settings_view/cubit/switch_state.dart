part of 'switch_cubit.dart';

@immutable
sealed class SwitchState {}

final class SwitchInitial extends SwitchState {}

final class SwitchDarkMode extends SwitchState {}

final class SwitchNotification extends SwitchState {}
