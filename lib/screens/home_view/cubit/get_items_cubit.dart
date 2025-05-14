import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/home_view/models/get_items_model/get_items_model.dart';

part 'get_items_cubit_state.dart';

class GetItemsCubit extends Cubit<GetItemsCubitState> {
  GetItemsCubit() : super(GetItemsCubitInitial());

  List<GetItemsModel> itemsList = [];
  final GetItemsModel getItemsModel = GetItemsModel();
    void clearItems() {
    itemsList.clear();
    emit(GetItemsCubitInitial()); 
  }
  Future<void> getItems() async {
    emit(GetItemsCubitLoading());
    final box = Hive.box<GetItemsModel>('itemsBox');
    if (box.isNotEmpty) {
      itemsList = box.values.toList();
      emit(GetItemsCubitSuccess(itemsList));
    }
    try {
      final response = await DioHelper.getData(path: 'items/latest');
      print("API Response: ${response.data}");
      // Ensure the response is a list before parsing
      if (response.data is List) {
        itemsList =
            (response.data as List)
                .map((item) => GetItemsModel.fromjson(item))
                .toList();

        await box.clear();
        await box.addAll(itemsList);
        emit(GetItemsCubitSuccess(itemsList));
      } else {
        emit(GetItemsCubitError("Invalid response format"));
      }
    } catch (e) {
      if (itemsList.isNotEmpty) {
        emit(GetItemsCubitSuccess(itemsList));
      } else {
        emit(GetItemsCubitError(e.toString()));
      }
    }
  }
  
}
