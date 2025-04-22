part of 'get_items_cubit.dart';

@immutable
abstract class GetItemsCubitState {}

class GetItemsCubitInitial extends GetItemsCubitState {}

class GetItemsCubitLoading extends GetItemsCubitState {}

class GetItemsCubitSuccess extends GetItemsCubitState {
  final List<GetItemsModel> items;
  GetItemsCubitSuccess(this.items);
}

class GetItemsCubitError extends GetItemsCubitState {
  final String error;
  GetItemsCubitError(this.error);
}

