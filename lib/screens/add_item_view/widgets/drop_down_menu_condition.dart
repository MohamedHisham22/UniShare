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
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
      list.map<MenuEntry>(
        (String name) => MenuEntry(
          value: name,
          label: name,
          style: MenuItemButton.styleFrom(
            foregroundColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
    final cubit = context.read<AddItemsCubit>();

    return DropdownMenu<String>(
      controller: cubit.conditionController,
      width: double.infinity,
      trailingIcon: Icon(
        Icons.arrow_drop_down,
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
      ),
      selectedTrailingIcon: Icon(
        Icons.arrow_drop_up,
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(
          Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
        ),
        elevation: WidgetStateProperty.all(4),
        shadowColor: WidgetStateProperty.all(Colors.black26),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
      textStyle: TextStyle(
        fontSize: 18,
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Color(0xff656565),
      ),
      inputDecorationTheme: InputDecorationTheme(
        constraints: BoxConstraints(maxHeight: 55, minHeight: 55),
        fillColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(0xffEAEAEA),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Color(0xffEAEAEA),
          ),
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
