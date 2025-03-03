import 'package:flutter/material.dart';
import 'package:unishare/screens/chat_view/views/chatting_view.dart';

class AllChatsView extends StatelessWidget {
  const AllChatsView({super.key});

  static String id = '/allChats';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: Text('Enter Chat', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.pushNamed(context, ChattingView.id);
          },
        ),
      ),
    );
  }
}
