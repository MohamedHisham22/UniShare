import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';

class CustomTextFieldPrice extends StatelessWidget {
  const CustomTextFieldPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddItemsCubit>();
    return SizedBox(
      width: 145,
      height: 55,
      child: TextField(
        controller: cubit.priceController,
        keyboardType: TextInputType.number,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'EGP',
              style: TextStyle(fontSize: 18, color: Color(0xff656565)),
            ),
          ),
          hintText: '150',
          hintStyle: TextStyle(fontSize: 18, color: Color(0xff656565)),

          fillColor: Color(0xffEAEAEA),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
