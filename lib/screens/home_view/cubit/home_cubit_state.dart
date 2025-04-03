part of 'home_cubit_cubit.dart';

@immutable
sealed class HomeCubitState {}

final class HomeCubitInitial extends HomeCubitState {}

class ImagePicked extends HomeCubitState {}
