part of 'chatting_view_cubit.dart';

@immutable
abstract class ChattingViewState {}

class ChattingViewInitial extends ChattingViewState {}

class ChatLoading extends ChattingViewState {}

class ChatLoaded extends ChattingViewState {
  final List<types.Message> messages;

  ChatLoaded(this.messages);
}

class ChatError extends ChattingViewState {
  final String message;

  ChatError(this.message);
}
