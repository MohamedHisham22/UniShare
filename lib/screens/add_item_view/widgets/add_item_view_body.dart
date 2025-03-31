import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';
import 'package:unishare/screens/add_item_view/widgets/custom_text_field_description.dart';
import 'package:unishare/screens/add_item_view/widgets/custom_text_field_duration.dart';
import 'package:unishare/screens/add_item_view/widgets/custom_text_field_item_name.dart';
import 'package:unishare/screens/add_item_view/widgets/custom_text_field_price.dart';
import 'package:unishare/screens/add_item_view/widgets/drop_down_menu_category.dart';
import 'package:unishare/screens/add_item_view/widgets/drop_down_menu_condition.dart';
import 'package:unishare/screens/add_item_view/widgets/drop_down_menu_listing_options.dart';
import 'package:unishare/screens/add_item_view/widgets/title_name.dart';
import 'package:unishare/screens/add_item_view/widgets/upload_image_button.dart';

class AddItemViewBody extends StatelessWidget {
  const AddItemViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddItemsCubit, AddItemsState>(
      builder: (context, state) {
        final cubit = context.read<AddItemsCubit>();
        return Padding(
          padding: const EdgeInsets.only(right: 25, left: 25),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        TitleName(text: 'Item Name:'),
                        SizedBox(height: 5),
                        CustomTextFieldItemName(),
                        SizedBox(height: 20),
                        TitleName(text: 'Description:'),
                        SizedBox(height: 5),
                        CustomTextFieldDescription(),
                        SizedBox(height: 20),
                        TitleName(text: 'Upload Images:'),
                        SizedBox(height: 5),
                        UploadingImage(),
                        SizedBox(height: 20),
                        TitleName(text: 'Choose Category'),
                        SizedBox(height: 5),
                        DropDownMenuCategory(),
                        SizedBox(height: 20),
                        TitleName(text: 'Condition'),
                        SizedBox(height: 5),
                        DropDownMenuCondition(),
                        SizedBox(height: 20),
                        TitleName(text: 'Listing Options'),
                        SizedBox(height: 5),
                        DropDownMenuListingOptions(
                          onOptionSelected: (value) {
                            cubit.onOptionSelected(value);
                          },
                        ),
                        SizedBox(height: 20),
                        if (cubit.selectedOption == 'Rent') ...[
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleName(text: 'Price'),
                                  SizedBox(height: 5),
                                  CustomTextFieldPrice(),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleName(text: 'Duration'),
                                  SizedBox(height: 5),
                                  CustomTextFieldDuration(),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                        if (cubit.selectedOption == 'Sell') ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleName(text: 'Price'),
                              SizedBox(height: 5),
                              CustomTextFieldPrice(),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
