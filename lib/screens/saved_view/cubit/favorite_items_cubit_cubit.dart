import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/saved_view/models/favorites_model.dart';

part 'favorite_items_cubit_state.dart';

class FavoriteItemsCubit extends Cubit<FavoriteItemsState> {
  FavoriteItemsCubit() : super(FavoriteItemsCubitInitial());

  List<String?> favoritedItemIds = [];
  List<FavoritesModel> favoritItems = [];
  FavoritesModel favoriteItemsModel = FavoritesModel();

  Future<void> addToFavorite({
    required String userId,
    required String itemId,
  }) async {
    emit(AddingToFavoriteLoading());
    try {
      final response = await DioHelper.postData(
        path: 'Favourites/',
        body: {"userId": userId, "itemId": itemId},
      );
      if (response.statusCode == 200) {
        favoritedItemIds.add(itemId);
        emit(AddingToFavoriteSuccess());
      } else {
        emit(AddingToFavoriteFailed());
      }
    } catch (e) {
      emit(AddingToFavoriteFailed());
    }
  }

  Future<void> getFavoriteItems({required String userId}) async {
    emit(GettingFavoritesLoading());
    try {
      final response = await DioHelper.getData(path: 'Favourites/$userId');
      if (response.statusCode == 200) {
        List tempList = response.data;
        favoritItems = tempList.map((e) => FavoritesModel.fromJson(e)).toList();
        favoritedItemIds = favoritItems.map((e) => e.itemId).toList();
        emit(GettingFavoritesSuccess());
      } else {
        emit(GettingFavoritesFailed());
      }
    } catch (e) {
      emit(GettingFavoritesFailed());
    }
  }

  void startAppWithFavoriteItems() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await getFavoriteItems(
        userId: FirebaseAuth.instance.currentUser?.uid ?? '',
      );
    }
  }

  Future<void> deleteFromFavorites({
    required String userId,
    required String itemId,
  }) async {
    emit(DeletingFromFavoriteLoading());
    try {
      final response = await DioHelper.deleteData(
        path: 'Favourites/remove',
        queryParameters: {'userId': userId, 'itemId': itemId},
      );
      if (response.statusCode == 200) {
        favoritedItemIds.remove(itemId);
        emit(DeletingFromFavoriteSuccess());
      } else {
        emit(DeletingFromFavoriteFailed());
      }
    } catch (e) {
      emit(DeletingFromFavoriteFailed());
    }
  }

  Future<void> toggleFavorite({
    required String userId,
    required String itemId,
  }) async {
    try {
      if (favoritedItemIds.contains(itemId)) {
        await deleteFromFavorites(userId: userId, itemId: itemId);

        emit(GettingFavoritesSuccess());
      } else {
        await addToFavorite(userId: userId, itemId: itemId);
        emit(GettingFavoritesSuccess());
      }
    } catch (error) {
      emit(GettingFavoritesFailed());
    }
    getFavoriteItems(userId: FirebaseAuth.instance.currentUser?.uid ?? '');
  }

  bool isItemFavorited(String itemId) {
    if (favoritedItemIds.contains(itemId)) {
      return true;
    } else {
      return false;
    }
  }
}
