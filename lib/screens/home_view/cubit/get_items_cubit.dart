import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/home_view/models/get_items_model/get_items_model.dart';

part 'get_items_cubit_state.dart';

class GetItemsCubit extends Cubit<GetItemsCubitState> {
  GetItemsCubit() : super(GetItemsCubitInitial());

  List<GetItemsModel> itemsList = [];

  Future<void> getItems() async {
    emit(GetItemsCubitLoading());
    try {
      final response = await DioHelper.getData(path: kUrl);
      print("API Response: ${response.data}");
      // Ensure the response is a list before parsing
      if (response.data is List) {
        itemsList =
            (response.data as List)
                .map((item) => GetItemsModel.fromjson(item))
                .toList();
        emit(GetItemsCubitSuccess(itemsList));
      } else {
        emit(GetItemsCubitError("Invalid response format"));
      }
    } catch (e) {
      emit(GetItemsCubitError(e.toString()));
    }
  }
}
