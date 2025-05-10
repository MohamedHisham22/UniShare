import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/home_view/models/recently_view_model/recently_view_model.dart';

part 'search_explore_recently_view_state.dart';

class SearchExploreRecentlyViewCubit
    extends Cubit<SearchExploreRecentlyViewState> {
  SearchExploreRecentlyViewCubit() : super(SearchExploreRecentlyViewInitial());
  List<RecentlyViewModel> recentlyList = [];
  String currentSearch = '';
  Future<void> recentlyView(String query) async {
    currentSearch = query;
    emit(SearchExploreRecentlyViewLoading());
    try {
      final response = await DioHelper.getData(
        path: 'Items/search?query=$query',
      );
      if (response.data is List) {
        recentlyList =
            (response.data as List)
                .map((item) => RecentlyViewModel.fromJson(item))
                .toList();
        emit(SearchExploreRecentlyViewSuccess());
      } else {
        emit(SearchExploreRecentlyViewErorr());
      }
    } catch (e) {
      emit(SearchExploreRecentlyViewErorr());
    }
  }
}
