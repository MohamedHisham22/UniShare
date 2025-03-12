import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/screens/chat_view/cubit/all_chats_view_cubit.dart';
import 'package:unishare/screens/chat_view/model/chat_room.dart';
import 'package:unishare/screens/chat_view/views/chatting_view.dart';

class SingleChatBar extends StatelessWidget {
  const SingleChatBar({
    super.key,
    required this.otherUserId,
    required this.cubit,
    required this.chatRoom,
    required this.unreadCount,
    required this.messageTime,
    required this.chats,
    required this.chat,
    required this.index,
  });

  final String otherUserId;
  final AllChatsViewCubit cubit;
  final ChatRoom chatRoom;
  final int unreadCount;
  final String messageTime;
  final List<QueryDocumentSnapshot<Object?>> chats;
  final Map<String, dynamic> chat;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(otherUserId.substring(0, 1).toUpperCase()),
      ),
      title: FutureBuilder(
        future: cubit.getUserName(otherUserId),
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Text(snapshot.data ?? "Loading...");
        },
      ),
      subtitle: Text(
        chatRoom.latestMessage ?? "No messages yet",
        style: TextStyle(
          color: unreadCount > 0 ? Colors.black : Colors.grey,
          fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            messageTime,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(width: 8),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ChattingView(
                  chatId: chats[index].id,
                  otherUserId: otherUserId,
                  otherUserName: chat['otherUserName'] ?? "Chat",
                ),
          ),
        );
      },
    );
  }
}
