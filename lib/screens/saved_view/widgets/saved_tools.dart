import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/saved_view/models/favorites_model.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/views/tool_details_view_client.dart';

class SavedTools extends StatelessWidget {
  const SavedTools({super.key, required this.item});
  final FavoritesModel item;
  @override
  Widget build(BuildContext context) {
    final itemDetailesCubit = context.read<ToolDetailesClientViewCubit>();

    return GestureDetector(
      onTap: () {
        itemDetailesCubit.showItemDetailes(itemID: item.itemId ?? '');
        Navigator.pushNamed(context, ToolDetailsViewClient.id);
      },
      child: Container(
        width: double.infinity,
        height: 114,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xffdcedef),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(item.itemImageUrl ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    item.itemName ?? 'Loading',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xff616161),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
