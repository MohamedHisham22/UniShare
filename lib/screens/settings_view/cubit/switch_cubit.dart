import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'switch_state.dart';

class SwitchCubit extends Cubit<SwitchState> {
  bool darkMode = false;
  bool notification = false;
  SwitchCubit() : super(SwitchInitial()) {
    _loadSettings();
  }

  void darkkMode(value) {
    darkMode = value;
    Hive.box('settings').put('isDarkMode', value);
    emit(SwitchDarkMode());
  }

  void notifi(value) {
    notification = value;
    emit(SwitchNotification());
  }

  void _loadSettings() {
    final box = Hive.box('settings');
    darkMode = box.get('isDarkMode', defaultValue: false);
  }
}
