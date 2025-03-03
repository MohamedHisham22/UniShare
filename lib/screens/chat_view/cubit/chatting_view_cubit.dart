import 'package:bloc/bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'chatting_view_state.dart';

class ChattingViewCubit extends Cubit<ChattingViewState> {
  ChattingViewCubit() : super(ChattingViewInitial());

  final List<types.Message> _messages = [];
  final types.User _currentUser = const types.User(id: 'user-1');

  void sendMessage(String text) {
    final newMessage = types.TextMessage(
      author: _currentUser,
      id: const Uuid().v4(),
      text: text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    _messages.insert(0, newMessage);
    emit(ChatLoaded(List.from(_messages)));
  }
}
