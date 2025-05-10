import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/home_view/models/get_items_model/get_items_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  List<GetItemsModel> itemsList = [];
  final GetItemsModel getItemsModel = GetItemsModel();

  String currentSearch = '';

  Future<void> exploreView(String query) async {
    currentSearch = query;
    emit(SearchLoading());
    try {
      final response = await DioHelper.getData(
        path: 'Items/search?query=$query',
      );
      print("Recently viewed response: ${response.data}");
      if (response.data is List) {
        itemsList =
            (response.data as List)
                .map((item) => GetItemsModel.fromjson(item))
                .toList();
        emit(SearchSuccess());
      } else {
        emit(SearchErorr());
      }
    } catch (e) {
      emit(SearchErorr());
    }
  }
}
