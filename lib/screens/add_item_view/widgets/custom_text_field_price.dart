import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';

class CustomTextFieldPrice extends StatelessWidget {
  const CustomTextFieldPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddItemsCubit>();
    return BlocBuilder<AddItemsCubit, AddItemsState>(
      builder: (context, state) {
        bool isDonate = cubit.optionsController.text == 'Donate';

        return isDonate
            ? SizedBox.shrink()
            : SizedBox(
              width: 145,
              height: 55,
              child: TextField(
                controller: cubit.priceController,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(top: 14.0, right: 12),
                    child: Text(
                      'EGP',
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Color(0xff656565),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hintText: '150',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Color(0xff656565),
                  ),
                  fillColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Color(0xffEAEAEA),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xffEAEAEA),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xffEAEAEA),
                    ),
                  ),
                ),
              ),
            );
      },
    );
  }
}
