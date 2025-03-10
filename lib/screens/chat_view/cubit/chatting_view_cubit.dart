import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:meta/meta.dart';

part 'chatting_view_state.dart';

class ChattingViewCubit extends Cubit<ChattingViewState> {
  ChattingViewCubit({required this.chatId, required this.otherUserId})
    : super(ChattingViewInitial());

  final String? chatId;
  final String? otherUserId;
  List<types.Message> messages = [];
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  StreamSubscription? _messagesSubscription;
  bool _isFirstLoad = true;

  final Map<String, types.User> _userCache = {};

  Future<void> initialize() async {
    if (chatId == null || otherUserId == null) {
      emit(ChatError("Missing chat information"));
      return;
    }

    _markMessagesAsRead();
    listenToMessages();
  }

  Future<void> _markMessagesAsRead() async {
    try {
      if (chatId != null) {
        await FirebaseFirestore.instance.collection('chats').doc(chatId).update(
          {'unreadCount_$currentUserId': 0},
        );
      }
    } catch (e) {
      print('Error marking messages as read: $e');
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    if (chatId == null || otherUserId == null) {
      emit(ChatError("Cannot send message: Missing chat information"));
      return;
    }

    final messageId = FirebaseFirestore.instance.collection('chats').doc().id;
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    var message = types.TextMessage(
      id: messageId,
      text: text,
      author: types.User(id: currentUserId),
      createdAt: timestamp,
      status: types.Status.sending,
    );

    messages.insert(0, message);
    emit(ChatLoaded(List.from(messages)));

    try {
      final batch = FirebaseFirestore.instance.batch();

      final messageRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId);

      batch.set(messageRef, {
        "id": messageId,
        "text": text,
        "senderId": currentUserId,
        "receiverId": otherUserId,
        "timestamp": timestamp,
        "status": "sent",
      });

      final chatRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId);
      batch.update(chatRef, {
        'latestMessage': text,
        'latestMessageTimestamp': FieldValue.serverTimestamp(),
        'unreadCount_$otherUserId': FieldValue.increment(1),
      });

      await batch.commit();

      final updatedMessage = message.copyWith(status: types.Status.sent);
      final messageIndex = messages.indexWhere((msg) => msg.id == messageId);
      if (messageIndex != -1) {
        messages[messageIndex] = updatedMessage;
        emit(ChatLoaded(List.from(messages)));
      }
    } catch (e) {
      final errorMessage = message.copyWith(status: types.Status.error);
      final messageIndex = messages.indexWhere((msg) => msg.id == messageId);
      if (messageIndex != -1) {
        messages[messageIndex] = errorMessage;
        emit(ChatLoaded(List.from(messages)));
      }
      emit(ChatError("Failed to send message: ${e.toString()}"));
    }
  }

  void listenToMessages() {
    if (chatId == null) {
      emit(ChatError("Cannot load messages: Chat ID is missing"));
      return;
    }

    emit(ChatLoading());

    _messagesSubscription = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(30)
        .snapshots()
        .listen(
          (snapshot) {
            messages =
                snapshot.docs.map((doc) {
                  final data = doc.data();
                  return types.TextMessage(
                    id: data['id'],
                    text: data['text'],
                    author: _getCachedUser(data['senderId']),
                    createdAt: data['timestamp'],
                    status: _mapStatus(data['status']),
                  );
                }).toList();

            if (_isFirstLoad) {
              _isFirstLoad = false;
              _markMessagesAsRead();
            }

            emit(ChatLoaded(List.from(messages)));
          },
          onError: (error) {
            emit(ChatError("Error loading messages: ${error.toString()}"));
          },
        );
  }

  Future<void> loadMoreMessages() async {
    if (chatId == null || messages.isEmpty) return;

    try {
      final lastTimestamp = messages.last.createdAt;

      final snapshot =
          await FirebaseFirestore.instance
              .collection('chats')
              .doc(chatId)
              .collection('messages')
              .orderBy('timestamp', descending: true)
              .startAfter([lastTimestamp])
              .limit(20)
              .get();

      if (snapshot.docs.isNotEmpty) {
        final olderMessages =
            snapshot.docs.map((doc) {
              final data = doc.data();
              return types.TextMessage(
                id: data['id'],
                text: data['text'],
                author: _getCachedUser(data['senderId']),
                createdAt: data['timestamp'],
                status: _mapStatus(data['status']),
              );
            }).toList();

        messages.addAll(olderMessages);
        emit(ChatLoaded(List.from(messages)));
      }
    } catch (e) {
      emit(ChatError("Error loading more messages: ${e.toString()}"));
    }
  }

  types.User _getCachedUser(String userId) {
    if (!_userCache.containsKey(userId)) {
      _userCache[userId] = types.User(id: userId);
    }
    return _userCache[userId]!;
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }

  types.Status _mapStatus(String status) {
    switch (status) {
      case "sent":
        return types.Status.sent;
      case "delivered":
        return types.Status.delivered;
      case "seen":
        return types.Status.seen;
      default:
        return types.Status.sending;
    }
  }
}
