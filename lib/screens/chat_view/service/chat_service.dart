import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String get currentUserId => _auth.currentUser?.uid ?? '';

  // Create or get existing chat between two users
  Future<String?> createOrGetChat(String otherUserId) async {
    if (currentUserId.isEmpty) {
      throw Exception("User not authenticated");
    }

    try {
      // Check if a chat already exists between these users
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

      // If no chat exists, create a new one
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

  // Delete chat (with proper cleanup)
  Future<void> deleteChat(String chatId) async {
    try {
      // Create a batch to ensure atomicity
      final batch = _firestore.batch();

      // First, delete all messages in the chat
      final messagesSnapshot =
          await _firestore
              .collection('chats')
              .doc(chatId)
              .collection('messages')
              .limit(500) // Firestore batches are limited to 500 operations
              .get();

      for (var doc in messagesSnapshot.docs) {
        batch.delete(doc.reference);
      }

      // Then delete the chat document itself
      batch.delete(_firestore.collection('chats').doc(chatId));

      // Commit the batch
      await batch.commit();

      // If there were more than 500 messages, we need to recursively delete them
      if (messagesSnapshot.docs.length == 500) {
        await deleteChat(chatId); // Recursive call to handle remaining messages
      }
    } catch (e) {
      print("Error deleting chat: $e");
      throw e;
    }
  }
}
