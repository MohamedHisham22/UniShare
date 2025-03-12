import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/screens/chat_view/cubit/all_chats_view_cubit.dart';
import 'package:unishare/screens/chat_view/model/chat_room.dart';
import 'package:unishare/screens/chat_view/widgets/single_chat_bar.dart';

class ChatsBuilder extends StatelessWidget {
  const ChatsBuilder({
    super.key,
    required this.chats,
    required this.currentUserId,
    required this.cubit,
  });

  final List<QueryDocumentSnapshot<Object?>> chats;
  final String currentUserId;
  final AllChatsViewCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index].data() as Map<String, dynamic>;
        final chatRoom = ChatRoom.fromMap(chat, chats[index].id);

        final otherUserId = chatRoom.participants.firstWhere(
          (id) => id != currentUserId,
          orElse: () => 'Unknown User',
        );

        final unreadCount = chatRoom.unreadCounts[currentUserId] ?? 0;

        final messageTime =
            chatRoom.latestMessageTimestamp != null
                ? cubit.formatTimestamp(chatRoom.latestMessageTimestamp!)
                : '';

        return SingleChatBar(
          otherUserId: otherUserId,
          cubit: cubit,
          chatRoom: chatRoom,
          unreadCount: unreadCount,
          messageTime: messageTime,
          chats: chats,
          chat: chat,
          index: index,
        );
      },
    );
  }
}
