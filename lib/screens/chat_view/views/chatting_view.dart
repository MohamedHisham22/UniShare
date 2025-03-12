import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/chat_view/cubit/chatting_view_cubit.dart';
import 'package:unishare/screens/chat_view/widgets/chat_view_body.dart';

class ChattingView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ChattingViewCubit(
          chatId: chatId,
          otherUserId: otherUserId,
        );
        cubit.initialize();
        return cubit;
      },
      child: ChattingViewBody(otherUserName: otherUserName),
    );
  }
}
