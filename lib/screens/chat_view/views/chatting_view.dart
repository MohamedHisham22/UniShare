import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:unishare/screens/chat_view/cubit/chatting_view_cubit.dart';

class ChattingView extends StatelessWidget {
  static String id = '/chatting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocBuilder<ChattingViewCubit, ChattingViewState>(
          builder: (context, state) {
            List<types.Message> messages = [];
            if (state is ChatLoaded) {
              messages = state.messages;
            }

            return Chat(
              messages: messages,
              onSendPressed: (partialText) {
                context.read<ChattingViewCubit>().sendMessage(partialText.text);
              },
              user: types.User(id: 'user-1'),
              theme: const DefaultChatTheme(
                backgroundColor: Colors.purple,
                inputBackgroundColor: Colors.blue,
                inputTextColor: Colors.white,
                sendButtonIcon: Icon(Icons.send),
                primaryColor: Colors.green,
                secondaryColor: Colors.grey,
              ),
              inputOptions: InputOptions(
                sendButtonVisibilityMode: SendButtonVisibilityMode.always,
              ),
            );
          },
        ),
      ),
    );
  }
}
