import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get currentUserId => _auth.currentUser?.uid ?? '';

  Future<String?> createOrGetChat(String otherUserId) async {
    if (currentUserId.isEmpty) {
      throw Exception("User not authenticated");
    }

    try {
      final query =
          await _firestore
              .collection('chats')
              .where('participants', arrayContains: currentUserId)
              .get();

      for (var doc in query.docs) {
        final participants = List<String>.from(doc['participants'] ?? []);
        if (participants.contains(otherUserId)) {
          return doc.id;
        }
      }

      final chatRef = _firestore.collection('chats').doc();

      await chatRef.set({
        'participants': [currentUserId, otherUserId],
        'createdAt': FieldValue.serverTimestamp(),
        'latestMessageTimestamp': FieldValue.serverTimestamp(),
        'unreadCount_$currentUserId': 0,
        'unreadCount_$otherUserId': 0,
      });

      return chatRef.id;
    } catch (e) {
      print("Error creating chat: $e");
      return null;
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      final batch = _firestore.batch();

      final messagesSnapshot =
          await _firestore
              .collection('chats')
              .doc(chatId)
              .collection('messages')
              .limit(500)
              .get();

      for (var doc in messagesSnapshot.docs) {
        batch.delete(doc.reference);
      }

      batch.delete(_firestore.collection('chats').doc(chatId));

      await batch.commit();

      if (messagesSnapshot.docs.length == 500) {
        await deleteChat(chatId);
      }
    } catch (e) {
      print("Error deleting chat: $e");
      throw e;
    }
  }
}
