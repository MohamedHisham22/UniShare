part of 'tool_detailes_client_view_cubit.dart';

@immutable
sealed class ToolDetailesClientViewState {}

final class ToolDetailesClientViewInitial extends ToolDetailesClientViewState {}

final class GettingItemDetailesLoading extends ToolDetailesClientViewState {}

final class GettingItemDetailesSuccess extends ToolDetailesClientViewState {}

final class GettingItemDetailesFailed extends ToolDetailesClientViewState {
  final String massege = 'Couldnt view this item please try again later';
}
