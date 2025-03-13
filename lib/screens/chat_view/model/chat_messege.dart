class ChatMessage {
  final String id;
  final String text;
  final String senderId;
  final String receiverId;
  final int timestamp;
  final String status;

  ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
    required this.status,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      timestamp: map['timestamp'] ?? 0,
      status: map['status'] ?? 'sent',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'status': status,
    };
  }
}
