import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';
import 'package:unishare/screens/add_item_view/views/add_item_view.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/tool_details_view_client_body.dart';

class ToolDetailsViewUser extends StatelessWidget {
  const ToolDetailsViewUser({super.key});
  static String id = '/toolDetailsUser';
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ToolDetailesClientViewCubit>();
    String priceText = 'Free';
    if (cubit.itemDetailes.itemPrice != null &&
        cubit.itemDetailes.itemPrice! > 0) {
      priceText = '${cubit.itemDetailes.itemPrice}';
    }
    return BlocBuilder<AddItemsCubit, AddItemsState>(
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(
          //   title: BackBotton(),
          //   automaticallyImplyLeading: false,
          //   toolbarHeight: 70,
          //   surfaceTintColor: Colors.transparent,
          // ),
          body: ToolDetailsViewClientBody(),
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 105,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border.all(color: Colors.grey, width: 0.8),
              //  Border(
              //   // top: BorderSide(color: Colors.grey, width: 0.9),
              //   // right: BorderSide(color: Colors.grey, width: 0.5),
              //   // left: BorderSide(color: Colors.grey, width: 0.5),

              // ),
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
                            cubit.itemDetailes.itemDuration == null ? '' : '/',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            cubit.itemDetailes.itemDuration ?? '',
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
                    child: GestureDetector(
                      onTap: () {
                        final item = cubit.itemDetailes;
                        final addCubit = context.read<AddItemsCubit>();

                        addCubit.populateFieldsForEditing(item);
                        
                        Navigator.pushNamed(context, AddItemView.id);
                      },
                      child: Container(
                        width: 130,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kPrimaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0),
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: Colors.white),
                              SizedBox(width: 20),

                              Text(
                                'Edit',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
