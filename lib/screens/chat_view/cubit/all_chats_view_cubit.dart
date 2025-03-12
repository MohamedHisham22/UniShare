import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'all_chats_view_state.dart';

class AllChatsViewCubit extends Cubit<AllChatsViewState> {
  AllChatsViewCubit() : super(AllChatsViewInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get currentUserId => _auth.currentUser?.uid ?? '';
  final Map<String, String> _userNameCache = {};

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
      emit(DisplayingChatsFailed(errorMessage: 'Error creating chat'));
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
      emit(DisplayingChatsFailed(errorMessage: 'Error deleting chat'));
    }
  }

  Future<String> getUserName(String userId) async {
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
      emit(DisplayingChatsFailed(errorMessage: 'Error fetching user data'));
    }

    return "User";
  }

  String formatTimestamp(DateTime timestamp) {
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
