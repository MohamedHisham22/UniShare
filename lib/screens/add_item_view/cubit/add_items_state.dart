part of 'add_items_cubit.dart';

@immutable
sealed class AddItemsState {}

final class AddItemsInitial extends AddItemsState {}

final class AddItemsOnOptionSelected extends AddItemsState {}

final class ImagePicked extends AddItemsState {}

final class ImageRemoved extends AddItemsState {}

class AddItemsLoading extends AddItemsState {}

class AddItemsSuccess extends AddItemsState {
    final bool wasEditing;

  AddItemsSuccess(this.wasEditing);
}

class AddItemsError extends AddItemsState {
  final String error;
  AddItemsError(this.error);
}
class AddItemsClearFields extends AddItemsState {}
class AddItemsFieldsPopulated extends AddItemsState {}

