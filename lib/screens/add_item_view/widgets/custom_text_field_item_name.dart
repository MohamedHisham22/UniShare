import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';

class CustomTextFieldItemName extends StatelessWidget {
  const CustomTextFieldItemName({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddItemsCubit>();
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Item name is required';
              }
              return null;
            },
            controller: cubit.itemNameController,
            cursorColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              hintText: 'Item Name',
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

              errorStyle: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                height: 0.8, // make error text take less space
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
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
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
