part of 'all_chats_view_cubit.dart';

@immutable
sealed class AllChatsViewState {}

final class AllChatsViewInitial extends AllChatsViewState {}

final class DisplayingChatsFailed extends AllChatsViewState {
  String errorMessage;
  DisplayingChatsFailed({required this.errorMessage});
}

final class ChatsSearched extends AllChatsViewState {
  final List<QueryDocumentSnapshot> filteredChats;
  ChatsSearched(this.filteredChats);
}

class CreatingChatLoading extends AllChatsViewState {}

class ChatCreatedSuccessfully extends AllChatsViewState {}
