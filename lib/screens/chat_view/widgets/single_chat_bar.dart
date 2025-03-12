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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      isThreeLine: true,
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.blue,
        child: Text(
          otherUserId.substring(0, 1).toUpperCase(),
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: FutureBuilder(
              future: cubit.getUserName(otherUserId),
              builder: (context, AsyncSnapshot<String> snapshot) {
                return Text(
                  snapshot.data ?? "Loading...",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Text(
            messageTime,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              chatRoom.latestMessage ?? "No messages yet",
              style: TextStyle(
                fontSize: 16,
                color: unreadCount > 0 ? Colors.black : Colors.grey,
                fontWeight:
                    unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
        ],
      ),
      onTap: () async {
        final userName = await cubit.getUserName(otherUserId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ChattingView(
                  chatId: chats[index].id,
                  otherUserId: otherUserId,
                  otherUserName: userName,
                ),
          ),
        );
      },
    );
  }
}
