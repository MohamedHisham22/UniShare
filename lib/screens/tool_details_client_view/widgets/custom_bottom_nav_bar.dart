import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/chat_view/cubit/all_chats_view_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.itemsDetailCubit});
  final ToolDetailesClientViewCubit itemsDetailCubit;

  @override
  Widget build(BuildContext context) {
    final chatCubit = context.read<AllChatsViewCubit>();
    String priceText = 'Free';
    if (itemsDetailCubit.itemDetailes.itemPrice != null &&
        itemsDetailCubit.itemDetailes.itemPrice! > 0) {
      priceText = '${itemsDetailCubit.itemDetailes.itemPrice}';
    }

    return BlocListener<AllChatsViewCubit, AllChatsViewState>(
      listener: (context, state) {
        if (state is DisplayingChatsFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: Container(
        width: double.infinity,
        height: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          border: Border.all(color: Colors.grey, width: 0.8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price', style: TextStyle(fontSize: 20)),
                  Row(
                    children: [
                      Text(
                        priceText,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        itemsDetailCubit.itemDetailes.itemDuration == null
                            ? ''
                            : '/',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        itemsDetailCubit.itemDetailes.itemDuration ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: BlocBuilder<AllChatsViewCubit, AllChatsViewState>(
                  builder: (context, state) {
                    bool isLoading = state is CreatingChatLoading;

                    return Container(
                      width: 160,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: kPrimaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: Row(
                          children: [
                            isLoading
                                ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                                : Icon(
                                  Icons.chat_bubble_outline,
                                  color: Colors.white,
                                ),
                            Spacer(),
                            GestureDetector(
                              onTap:
                                  isLoading
                                      ? null
                                      : () {
                                        chatCubit.createOrGetChatAndNavigate(
                                          context,
                                          itemsDetailCubit.itemDetailes.userId!,
                                        );
                                      },
                              child: Text(
                                'Open Chat',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
