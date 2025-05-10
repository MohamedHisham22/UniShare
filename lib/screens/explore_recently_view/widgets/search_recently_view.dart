import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchRecentlyView extends StatelessWidget {
  const SearchRecentlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      decoration: InputDecoration(
        hintText: 'Search for tools and more...',
        hintStyle: TextStyle(
          fontSize: 18,
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Color(0xff828282),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(
            CupertinoIcons.search,
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Color(0xff828282),
          ),
        ),
        fillColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(0xffDEDEDE),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Color(0xffDEDEDE),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Color(0xffDEDEDE),
          ),
        ),
      ),
    );
  }
}