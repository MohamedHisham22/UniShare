part of 'search_explore_recently_view_cubit.dart';

@immutable
sealed class SearchExploreRecentlyViewState {}

final class SearchExploreRecentlyViewInitial extends SearchExploreRecentlyViewState {}
final class SearchExploreRecentlyViewLoading extends SearchExploreRecentlyViewState {}
final class SearchExploreRecentlyViewSuccess extends SearchExploreRecentlyViewState {}
final class SearchExploreRecentlyViewErorr extends SearchExploreRecentlyViewState {}
