import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id;
  final List<String> participants;
  final String? latestMessage;
  final DateTime? latestMessageTimestamp;
  final Map<String, int> unreadCounts;

  ChatRoom({
    required this.id,
    required this.participants,
    this.latestMessage,
    this.latestMessageTimestamp,
    required this.unreadCounts,
  });

  factory ChatRoom.fromMap(Map<String, dynamic> map, String documentId) {
    Map<String, int> unreadCounts = {};

    // Extract unread counts for all participants
    map.forEach((key, value) {
      if (key.startsWith('unreadCount_')) {
        String userId = key.substring('unreadCount_'.length);
        unreadCounts[userId] = value as int;
      }
    });

    return ChatRoom(
      id: documentId,
      participants: List<String>.from(map['participants'] ?? []),
      latestMessage: map['latestMessage'],
      latestMessageTimestamp:
          (map['latestMessageTimestamp'] as Timestamp?)?.toDate(),
      unreadCounts: unreadCounts,
    );
  }
}
