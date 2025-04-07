import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/listing_view/models/my_listing_model/my_listing_model.dart';

part 'my_listing_state.dart';

class MyListingCubit extends Cubit<MyListingState> {
  MyListingCubit() : super(MyListingInitial());


  List<MyListingModel> myListing = [];

  Future<void> getItems(String? userId) async {
    emit(MyListingLoading());
    try {
      final response = await DioHelper.getData(path: 'items/user/$userId');

      if (response.data is List) {
        myListing =
            (response.data as List)
                .map((item) => MyListingModel.fromJson(item))
                .toList();
        emit(MyListingSuccess(myListing));
        
      } else {
        emit(MyListingErorr('Invalid response format'));
      }
    } catch (e) {
      emit(MyListingErorr(e.toString()));
    }
  }

  void startAppWithListing() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    print("UID used in API call: $uid");
    if (uid != null) {
      await getItems(uid);
    }
  }

    void deleteitem({required String itemId}) async {
    emit(DeleteItemLoading());
    try {
      final response = await DioHelper.deleteData(
        path: 'items/$itemId',
      );
      if (response.statusCode == 200) {
        myListing.removeWhere((item) => item.itemId == itemId);
        emit(MyListingSuccess(myListing));
      } else {
        emit(DeleteItemErorr());
      }
    } catch (e) {
      emit(DeleteItemErorr());
    }
  }
}
