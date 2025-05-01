import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';

class CustomTextFieldDescription extends StatelessWidget {
  const CustomTextFieldDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddItemsCubit>();
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Item description is required';
        }
        return null;
      },
      controller: cubit.descriptionController,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: null,
      cursorColor:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          height: 0.8,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: 'Item Description',
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
    );
  }
}
