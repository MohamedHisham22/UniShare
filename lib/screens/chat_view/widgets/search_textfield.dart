import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/chat_view/cubit/all_chats_view_cubit.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.searchController,
    required this.cubit,
    required this.chats,
  });

  final TextEditingController searchController;
  final AllChatsViewCubit cubit;
  final List<QueryDocumentSnapshot<Object?>> chats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search Chats',
          hintStyle: TextStyle(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey
                    : Colors.black,
          ),
          prefixIcon: Icon(
            Icons.search,
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey
                    : Colors.black,
          ),
          suffixIcon: BlocBuilder<AllChatsViewCubit, AllChatsViewState>(
            builder: (context, state) {
              return searchController.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      cubit.searchChats(chats, '');
                      FocusScope.of(context).unfocus();
                    },
                  )
                  : const SizedBox.shrink();
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: (value) {
          cubit.searchChats(chats, value);
        },
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
      ),
    );
  }
}
