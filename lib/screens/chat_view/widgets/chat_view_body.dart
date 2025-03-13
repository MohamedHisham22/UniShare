import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/chat_view/cubit/chatting_view_cubit.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:unishare/screens/chat_view/widgets/chat_contents.dart';

class ChattingViewBody extends StatelessWidget {
  const ChattingViewBody({Key? key, required this.otherUserName})
    : super(key: key);

  final String? otherUserName;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChattingViewCubit>();

    return BlocListener<ChattingViewCubit, ChattingViewState>(
      listener: (context, state) {
        if (state is ChatError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: Text(otherUserName ?? "User"),
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
                      Text("Error Loading Chat"),
                      TextButton(
                        onPressed: () => cubit.listenToMessages(),
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

              return ChatContents(messages: messages, cubit: cubit);
            },
          ),
        ),
      ),
    );
  }
}
