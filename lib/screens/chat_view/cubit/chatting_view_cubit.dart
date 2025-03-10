import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
  final Map<String, bool> _sendingMessages = {};
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
        var batch = FirebaseFirestore.instance.batch();
        var unreadMessages =
            await FirebaseFirestore.instance
                .collection('chats')
                .doc(chatId)
                .collection('messages')
                .where('senderId', isEqualTo: otherUserId)
                .where('status', isEqualTo: 'sent')
                .get();

        for (var doc in unreadMessages.docs) {
          batch.update(doc.reference, {'status': 'seen'});
        }

        await batch.commit();
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

    // Mark this message as currently sending
    _sendingMessages[messageId] = true;

    // Create message with sending status
    var message = types.TextMessage(
      id: messageId,
      text: text,
      author: types.User(id: currentUserId),
      createdAt: timestamp,
      status: types.Status.sending,
    );

    // Add to UI immediately with sending status
    messages.insert(0, message);
    emit(ChatLoaded(List.from(messages)));

    var connectivityResult = await Connectivity().checkConnectivity();
    bool isConnected = connectivityResult != ConnectivityResult.none;

    if (!isConnected) {
      // Update to error status if no connection
      _sendingMessages.remove(messageId);
      final errorMessage = message.copyWith(status: types.Status.error);
      final messageIndex = messages.indexWhere((msg) => msg.id == messageId);
      if (messageIndex != -1) {
        messages[messageIndex] = errorMessage;
        emit(ChatLoaded(List.from(messages)));
      }
      return;
    }

    try {
      // Proceed with sending to Firebase
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
        "status": "sending", // Store as sending in Firebase initially
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

      // Now update the status to sent in Firebase
      await messageRef.update({'status': 'sent'});

      // Remove from sending messages
      _sendingMessages.remove(messageId);
    } catch (e) {
      // Update to error status if Firebase operation fails
      _sendingMessages.remove(messageId);

      // Only update if the message is still in our list
      final messageIndex = messages.indexWhere((msg) => msg.id == messageId);
      if (messageIndex != -1) {
        final errorMessage = messages[messageIndex].copyWith(
          status: types.Status.error,
        );
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
                    status: _mapStatus(data['status'], data['id']),
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
                status: _mapStatus(data['status'], data['id']),
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

  types.Status _mapStatus(String status, String messageId) {
    // If message is actively sending and status is not 'sent' or 'seen', show as sending
    // This change allows Firebase updates to override local sending state
    if (_sendingMessages.containsKey(messageId) &&
        _sendingMessages[messageId] == true &&
        status != 'sent' &&
        status != 'seen') {
      return types.Status.sending;
    }

    switch (status) {
      case "sent":
        return types.Status.sent;
      case "seen":
        return types.Status.seen;
      case "error":
        return types.Status.error;
      case "sending":
        return types.Status.sending;
      default:
        return types.Status.sending;
    }
  }
}
