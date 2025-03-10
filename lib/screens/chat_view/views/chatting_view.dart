import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:unishare/screens/chat_view/cubit/chatting_view_cubit.dart';

class ChattingView extends StatefulWidget {
  const ChattingView({
    Key? key,
    required this.chatId,
    required this.otherUserId,
    this.otherUserName,
  }) : super(key: key);

  final String chatId;
  final String otherUserId;
  final String? otherUserName;

  static String id = '/chatting';

  @override
  State<ChattingView> createState() => _ChattingViewState();
}

class _ChattingViewState extends State<ChattingView> {
  late final ChattingViewCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ChattingViewCubit(
      chatId: widget.chatId,
      otherUserId: widget.otherUserId,
    );
    _cubit.initialize();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.otherUserName ?? "Chat"),
          elevation: 1,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: BlocBuilder<ChattingViewCubit, ChattingViewState>(
            builder: (context, state) {
              if (state is ChatLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ChatError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Error: ${state.message}"),
                      TextButton(
                        onPressed: () => _cubit.listenToMessages(),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              }

              List<types.Message> messages = [];
              if (state is ChatLoaded) {
                messages = state.messages;
              }

              return Chat(
                messages: messages,
                onSendPressed:
                    (partialText) => _cubit.sendMessage(partialText.text),
                user: types.User(id: _cubit.currentUserId),
                theme: const DefaultChatTheme(
                  backgroundColor: Colors.white,
                  inputBackgroundColor: Colors.grey,
                  inputTextColor: Colors.black87,
                  primaryColor: Colors.blue,
                  secondaryColor: Colors.grey,
                  sendButtonIcon: Icon(Icons.send),
                ),
                inputOptions: const InputOptions(
                  sendButtonVisibilityMode: SendButtonVisibilityMode.always,
                ),
                // Add load more capability to reduce initial data transfer
                onEndReached: () => _cubit.loadMoreMessages(),
              );
            },
          ),
        ),
      ),
    );
  }
}
