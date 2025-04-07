import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';

const List<String> list = <String>['Excellent', 'Poor', 'Fair'];

class DropDownMenuCondition extends StatefulWidget {
  const DropDownMenuCondition({super.key});

  @override
  State<DropDownMenuCondition> createState() => _DropDownMenuConditionState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropDownMenuConditionState extends State<DropDownMenuCondition> {
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    list.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddItemsCubit>();

    return DropdownMenu<String>(
      controller: cubit.conditionController,
      width: double.infinity,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        elevation: WidgetStateProperty.all(4),
        shadowColor: WidgetStateProperty.all(Colors.black26),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
          cubit.conditionController.text = value; // ✅ Store selected value
        }
      },
      dropdownMenuEntries: menuEntries,
    );
  }
}
