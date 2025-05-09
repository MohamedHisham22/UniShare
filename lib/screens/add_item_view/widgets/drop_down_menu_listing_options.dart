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
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AddItemsCubit>();

    final valueFromCubit = cubit.optionsController.text.trim();

    if (list.contains(valueFromCubit)) {
      dropdownValue = valueFromCubit;
    } else {
      dropdownValue = list.first;
      cubit.optionsController.text = list.first;
    }
  }

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
      controller: cubit.optionsController,
      width: double.infinity,
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
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        if (value != null) {
          setState(() {
            dropdownValue = value;
          });
          cubit.optionsController.text = value;

          widget.onOptionSelected(value);
        }
      },
      dropdownMenuEntries: menuEntries,
    );
  }
}
