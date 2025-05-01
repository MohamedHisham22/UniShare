import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';

class CustomTextFieldDuration extends StatefulWidget {
  const CustomTextFieldDuration({super.key});

  @override
  State<CustomTextFieldDuration> createState() =>
      _CustomTextFieldDurationState();
}

class _CustomTextFieldDurationState extends State<CustomTextFieldDuration> {
  String? selectedMonth;

  final List<String> months = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddItemsCubit>();

    return SizedBox(
      width: 145,
      height: 55,
      child: DropdownButtonFormField<String>(
        iconEnabledColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
        iconDisabledColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
        value:
            cubit.durationController.text.isNotEmpty
                ? cubit.durationController.text
                : null,
        onChanged: (value) {
          setState(() {
            selectedMonth = value;
            // Update the cubit's durationController with the selected value
            cubit.durationController.text = selectedMonth!;
          });
        },
        decoration: InputDecoration(
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
        hint: Text(
          'Duration',
          style: TextStyle(
            fontSize: 16,
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Color(0xff656565),
          ),
        ),
        items:
            months.map((month) {
              return DropdownMenuItem(
                value: month,
                child: Text(
                  month,
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Color(0xff656565),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
