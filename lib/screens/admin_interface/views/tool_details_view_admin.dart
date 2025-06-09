import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';
import 'package:unishare/screens/listing_view/cubit/my_listing_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/tool_details_view_client_body.dart';

class ToolDetailsViewAdmin extends StatelessWidget {
  const ToolDetailsViewAdmin({super.key});
  static String id = '/toolDetailsAdmin';
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ToolDetailesClientViewCubit>();
    final itemCubit = context.read<MyListingCubit>();
    String priceText = 'Free';
    if (cubit.itemDetailes.itemPrice != null &&
        cubit.itemDetailes.itemPrice! > 0) {
      priceText = '${cubit.itemDetailes.itemPrice}';
    }
    return BlocListener<MyListingCubit, MyListingState>(
      listener: (context, state) {
        if (state is DeleteItem2Success) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: 'Success!',
            desc: 'Item Has Been Deleted Successfully!',
            btnOkOnPress: () {
              Navigator.pop(context);
            },
          ).show();
        }
      },
      child: BlocBuilder<AddItemsCubit, AddItemsState>(
        builder: (context, state) {
          if (state is GettingItemDetailesLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            return ModalProgressHUD(
              inAsyncCall: state is DeleteItem2Loading,
              child: Scaffold(
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
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
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
                                  cubit.itemDetailes.itemDuration == null
                                      ? ''
                                      : '/',
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
                            onTap: () async {
                              itemCubit.deleteitem2(
                                itemId: cubit.itemDetailes.itemId!,
                                context: context,
                              );
                            },
                            child: Container(
                              width: 130,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 13.0,
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, color: Colors.white),
                                    SizedBox(width: 20),

                                    Text(
                                      'Delete',
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
              ),
            );
          }
        },
      ),
    );
  }
}
