part of 'chatting_view_cubit.dart';

@immutable
sealed class ChattingViewState {}

final class ChattingViewInitial extends ChattingViewState {}

class ChatLoaded extends ChattingViewState {
  final List<types.Message> messages;
  ChatLoaded(this.messages);
}
