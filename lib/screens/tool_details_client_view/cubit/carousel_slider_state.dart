part of 'carousel_slider_cubit.dart';

@immutable
sealed class CarousellSliderState {}

final class CarouselSliderInitial extends CarousellSliderState {}

final class CarouselSliderPageChanged extends CarousellSliderState {}
