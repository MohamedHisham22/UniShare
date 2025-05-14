part of 'recently_viewed_cubit.dart';

@immutable
sealed class RecentlyViewedState {}

final class RecentlyViewedInitial extends RecentlyViewedState {}

class RecentlyCubitLoading extends RecentlyViewedState {}
class RecentlyCubitClear extends RecentlyViewedState {}

class RecentlyCubitSuccess extends RecentlyViewedState {
  final List<RecentlyViewModel> recentlyItems;
  RecentlyCubitSuccess(this.recentlyItems);
}

class RecentlyCubitErorr extends RecentlyViewedState {
  final String error;
  RecentlyCubitErorr(this.error);
}
