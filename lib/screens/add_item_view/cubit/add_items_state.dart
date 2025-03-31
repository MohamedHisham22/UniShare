part of 'add_items_cubit.dart';

@immutable
sealed class AddItemsState {}

final class AddItemsInitial extends AddItemsState {}

final class AddItemsOnOptionSelected extends AddItemsState {}

final class ImagePicked extends AddItemsState {}

final class ImageRemoved extends AddItemsState {}
