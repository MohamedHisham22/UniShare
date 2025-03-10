import 'package:flutter/material.dart';
import 'package:unishare/screens/chat_view/service/chat_service.dart';

class TestChatScreen extends StatelessWidget {
  final ChatService chatService = ChatService();

  void testCreateChat() async {
    String? chatId = await chatService.createOrGetChat(
      "JeSiJDV1XReuPV8Mm9r2kdV5s8f2",
    ); // Replace with a real user ID

    if (chatId != null) {
      print("✅ Chat created successfully! Chat ID: $chatId");
    } else {
      print("❌ Failed to create chat.");
    }
  }

  static String id = '/test';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Chat")),
      body: Center(
        child: ElevatedButton(
          onPressed: testCreateChat,
          child: Text("Create Chat"),
        ),
      ),
    );
  }
}
