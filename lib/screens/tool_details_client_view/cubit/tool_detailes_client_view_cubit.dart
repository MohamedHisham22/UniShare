import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unishare/helpers/dio_helper.dart';
import 'package:unishare/screens/tool_details_client_view/model/item_detailes_model.dart';

part 'tool_detailes_client_view_state.dart';

class ToolDetailesClientViewCubit extends Cubit<ToolDetailesClientViewState> {
  ToolDetailesClientViewCubit() : super(ToolDetailesClientViewInitial());

  ItemDetailesModel itemDetailes = ItemDetailesModel();
  Future <void> showItemDetailes({required String itemID}) async {
    // Reset the item details before loading new data for another item
    itemDetailes = ItemDetailesModel();
    emit(GettingItemDetailesLoading());
    try {
      final response = await DioHelper.getData(path: 'items/$itemID');
      itemDetailes = ItemDetailesModel.fromJson(response.data);
      if (response.statusCode == 200) {
        emit(GettingItemDetailesSuccess());
      } else {
        emit(GettingItemDetailesFailed());
      }
    } catch (e) {
      emit(GettingItemDetailesFailed());
    }
  }
}
