import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'switch_state.dart';

class SwitchCubit extends Cubit<SwitchState> {
  bool darkMode = false;
  bool notification = false;
  SwitchCubit() : super(SwitchInitial());

  void darkkMode(value) {
    darkMode = value;
    emit(SwitchDarkMode());
  }

  void notifi(value) {
    notification = value;
    emit(SwitchNotification());
  }
}
