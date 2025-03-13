import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/chat_view/cubit/all_chats_view_cubit.dart';
import 'package:unishare/screens/chat_view/widgets/chats_builder.dart';
import 'package:unishare/screens/chat_view/widgets/custom_appbar.dart';
import 'package:unishare/screens/chat_view/widgets/search_textfield.dart';

class AllChatsView extends StatelessWidget {
  AllChatsView({Key? key}) : super(key: key);

  static String id = '/allChats';
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final cubit = context.read<AllChatsViewCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
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
            return const Center(child: Text("Error Loading Chats"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No chats yet. Start a conversation!"),
            );
          }

          final chats = snapshot.data!.docs;

          return Column(
            children: [
              SearchTextField(
                searchController: searchController,
                cubit: cubit,
                chats: chats,
              ),
              Expanded(
                child: BlocBuilder<AllChatsViewCubit, AllChatsViewState>(
                  builder: (context, state) {
                    List<QueryDocumentSnapshot> displayChats = chats;

                    if (state is ChatsSearched) {
                      displayChats = state.filteredChats;
                    }

                    return ChatsBuilder(
                      chats: displayChats,
                      currentUserId: currentUserId,
                      cubit: cubit,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
