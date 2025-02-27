import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_items_state.dart';

class AddItemsCubit extends Cubit<AddItemsState> {
  String selectedOption = 'Donate';
  AddItemsCubit() : super(AddItemsInitial());

  void onOptionSelected(String value) {
    selectedOption = value;
    emit(AddItemsOnOptionSelected());
  }
}
