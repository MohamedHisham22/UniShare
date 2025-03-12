part of 'all_chats_view_cubit.dart';

@immutable
sealed class AllChatsViewState {}

final class AllChatsViewInitial extends AllChatsViewState {}

final class DisplayingChatsFailed extends AllChatsViewState {
  String errorMessage;
  DisplayingChatsFailed({required this.errorMessage});
}
