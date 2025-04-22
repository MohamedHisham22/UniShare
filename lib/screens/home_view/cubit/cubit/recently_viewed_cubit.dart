import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/home_view/models/recently_view_model/recently_view_model.dart';

part 'recently_viewed_state.dart';

class RecentlyViewedCubit extends Cubit<RecentlyViewedState> {
  RecentlyViewedCubit() : super(RecentlyViewedInitial());
  List<RecentlyViewModel> recentlyList = [];

   Future<void> recentlyView(String userID) async {
    emit(RecentlyCubitLoading());
    try {
      final response = await DioHelper.getData(
        path: 'Items/recently-viewed/$userID',
      );
      print("Recently viewed response: ${response.data}");
      if (response.data is List) {
        recentlyList =
            (response.data as List)
                .map((item) => RecentlyViewModel.fromJson(item))
                .toList();
        emit(RecentlyCubitSuccess(recentlyList));
      } else {
        emit(RecentlyCubitErorr("Invalid response format"));
      }
    } catch (e) {
      emit(RecentlyCubitErorr(e.toString()));
    }
  }
}
