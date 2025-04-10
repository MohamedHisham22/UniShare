part of 'favorite_items_cubit_cubit.dart';

@immutable
sealed class FavoriteItemsState {}

final class FavoriteItemsCubitInitial extends FavoriteItemsState {}

final class AddingToFavoriteLoading extends FavoriteItemsState {}

final class AddingToFavoriteSuccess extends FavoriteItemsState {}

final class AddingToFavoriteFailed extends FavoriteItemsState {
  final String massege = 'Couldnt Add To Favorites Please Try Again Later';
}

final class GettingFavoritesLoading extends FavoriteItemsState {}

final class GettingFavoritesSuccess extends FavoriteItemsState {}

final class GettingFavoritesFailed extends FavoriteItemsState {
  final String massege = 'Couldnt Load Favorites Please Try Again Later';
}

final class DeletingFromFavoriteLoading extends FavoriteItemsState {}

final class DeletingFromFavoriteSuccess extends FavoriteItemsState {}

final class DeletingFromFavoriteFailed extends FavoriteItemsState {
  final String massege = 'Couldnt Remove From Favorites Please Try Again Later';
}
