part of 'my_listing_cubit.dart';

@immutable
abstract class MyListingState {}

final class MyListingInitial extends MyListingState {}

final class MyListingLoading extends MyListingState {}

final class MyListingSuccess extends MyListingState {
  final List<MyListingModel> listing;
  MyListingSuccess(this.listing);
}

final class MyListingErorr extends MyListingState {
  final String erorr;
  MyListingErorr(this.erorr);
}

final class DeleteItemLoading extends MyListingState {}

final class DeleteItemSuccess extends MyListingState {
  final List<MyListingModel> listing;
  DeleteItemSuccess(this.listing);
}

final class DeleteItemErorr extends MyListingState {}
