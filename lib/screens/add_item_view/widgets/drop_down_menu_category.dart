import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:unishare/screens/add_item_view/cubit/add_items_cubit.dart';

const List<String> list = <String>['Tools', 'Books', 'Electronics'];

class DropDownMenuCategory extends StatefulWidget {
  const DropDownMenuCategory({super.key, required this.cubit});
  final AddItemsCubit cubit;
  @override
  State<DropDownMenuCategory> createState() => _DropDownMenuCategoryState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropDownMenuCategoryState extends State<DropDownMenuCategory> {
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
    return DropdownMenu<String>(
      controller: widget.cubit.categoryController,
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
        ), // خلفية القائمة
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
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: menuEntries,
    );
  }
}
