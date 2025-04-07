import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/home_view/cubit/get_items_cubit.dart';
import 'package:unishare/screens/listing_view/cubit/my_listing_cubit.dart';
import 'package:unishare/screens/listing_view/models/my_listing_model/my_listing_model.dart';

class ListingToolsDetails extends StatelessWidget {
  const ListingToolsDetails({super.key, required this.item});
  final MyListingModel item;

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyListingCubit>();
    return Container(
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
                  image:
                      item.imageUrl != null && item.imageUrl!.isNotEmpty
                          ? NetworkImage(item.imageUrl!)
                          : const AssetImage('assets/images/tools.png')
                              as ImageProvider,
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
                  item.itemName ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xff616161),
                  ),
                ),

                Text(
                  '${DateTime.now().day.toString().padLeft(2, '0')} '
                  '${_getMonthName(DateTime.now().month)} '
                  '${DateTime.now().year}',
                  style: TextStyle(fontSize: 18, color: Color(0xffC1839F)),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Delete item'),
                      content: Text('Are you sure you want to delete item?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            cubit.deleteitem(itemId: item.itemId!);
                            Navigator.of(context).pop();
                            await context.read<GetItemsCubit>()
                              ..getItems();
                          },
                          child: Text('Remove'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.delete, color: Colors.red, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
