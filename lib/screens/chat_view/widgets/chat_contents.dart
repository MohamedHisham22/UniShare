import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:unishare/screens/chat_view/cubit/chatting_view_cubit.dart';

class ChatContents extends StatelessWidget {
  const ChatContents({super.key, required this.messages, required this.cubit});

  final List<types.Message> messages;
  final ChattingViewCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Chat(
      messages: messages,
      onSendPressed: (partialText) => cubit.sendMessage(partialText.text),
      user: types.User(id: cubit.currentUserId),
      theme: DefaultChatTheme(
        backgroundColor: Color.fromARGB(212, 223, 222, 222),
        inputBackgroundColor: Colors.white,
        inputTextColor: Colors.black87,
        primaryColor: Colors.blue,
        secondaryColor: Colors.white,
        sendButtonIcon: Icon(
          Icons.send,
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.black,
        ),
        sendingIcon: Icon(Icons.access_time, size: 18, color: Colors.grey),
        deliveredIcon: Icon(Icons.done, size: 18, color: Colors.grey),
        seenIcon: Icon(Icons.done_all, size: 18, color: Colors.blue),
      ),
      inputOptions: const InputOptions(
        sendButtonVisibilityMode: SendButtonVisibilityMode.always,
      ),
      onEndReached: () => cubit.loadMoreMessages(),
    );
  }
}
