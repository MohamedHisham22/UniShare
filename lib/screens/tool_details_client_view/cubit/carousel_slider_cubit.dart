import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:meta/meta.dart';

part 'carousel_slider_state.dart';

class CarouselSliderCubit extends Cubit<CarousellSliderState> {
  CarouselSliderCubit() : super(CarouselSliderInitial());
    final CarouselSliderController carouselSliderController =
      CarouselSliderController();
  int currentIndex = 0;
  void onPageChanged(int index) {
    currentIndex = index;
    emit(CarouselSliderPageChanged());
  }
}
