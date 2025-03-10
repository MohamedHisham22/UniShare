import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/chat_view/model/chat_room.dart';
import 'package:unishare/screens/chat_view/views/chatting_view.dart';

class AllChatsView extends StatelessWidget {
  AllChatsView({Key? key}) : super(key: key);

  static String id = '/allChats';

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        toolbarHeight: 85,
        title: Text(
          'Chats',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: kPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance
                .collection('chats')
                .where('participants', arrayContains: currentUserId)
                .orderBy('latestMessageTimestamp', descending: true)
                .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No chats yet. Start a conversation!"),
            );
          }

          final chats = snapshot.data!.docs;

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
                      ? _formatTimestamp(chatRoom.latestMessageTimestamp!)
                      : '';

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(otherUserId.substring(0, 1).toUpperCase()),
                ),
                title: FutureBuilder(
                  future: _getUserName(otherUserId),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    return Text(snapshot.data ?? "Loading...");
                  },
                ),
                subtitle: Text(
                  chatRoom.latestMessage ?? "No messages yet",
                  style: TextStyle(
                    color: unreadCount > 0 ? Colors.black : Colors.grey,
                    fontWeight:
                        unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
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
            },
          );
        },
      ),
    );
  }

  final Map<String, String> _userNameCache = {};

  Future<String> _getUserName(String userId) async {
    if (_userNameCache.containsKey(userId)) {
      return _userNameCache[userId]!;
    }

    try {
      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();

      if (userDoc.exists) {
        final userData = userDoc.data();
        final name = userData?['name'] ?? userData?['displayName'] ?? "User";
        _userNameCache[userId] = name;
        return name;
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }

    return "User";
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(
      timestamp.year,
      timestamp.month,
      timestamp.day,
    );

    if (messageDate == today) {
      return "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return "Yesterday";
    } else if (now.difference(messageDate).inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[timestamp.weekday - 1];
    } else {
      return "${timestamp.day}/${timestamp.month}/${timestamp.year}";
    }
  }
}
