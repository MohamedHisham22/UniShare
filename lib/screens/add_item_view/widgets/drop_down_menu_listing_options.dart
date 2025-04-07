import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';

const List<String> list = <String>['Donate', 'Sell', 'Rent'];

class DropDownMenuListingOptions extends StatefulWidget {
  final Function(String) onOptionSelected;
  const DropDownMenuListingOptions({super.key, required this.onOptionSelected});

  @override
  State<DropDownMenuListingOptions> createState() =>
      _DropDownMenuListingOptionsState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropDownMenuListingOptionsState
    extends State<DropDownMenuListingOptions> {
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    list.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddItemsCubit>();
    return DropdownMenu<String>(
      controller: cubit.optionsController,
      width: double.infinity,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white), // خلفية القائمة
        elevation: WidgetStateProperty.all(4), // تأثير الارتفاع للظل
        shadowColor: WidgetStateProperty.all(Colors.black26), // لون الظل
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            ), // حواف دائرية للقائمة المنسدلة
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
      textStyle: TextStyle(fontSize: 18, color: Color(0xff656565)),
      inputDecorationTheme: InputDecorationTheme(
        constraints: BoxConstraints(maxHeight: 55, minHeight: 55),
        fillColor: Color(0xffEAEAEA),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      initialSelection: list.first,
      onSelected: (String? value) {
        if (value != null) {
          setState(() {
            dropdownValue = value;
          });
          cubit.optionsController.text = value;
          widget.onOptionSelected(value); // Notify parent widget
        }
      },
      dropdownMenuEntries: menuEntries,
    );
  }
}
