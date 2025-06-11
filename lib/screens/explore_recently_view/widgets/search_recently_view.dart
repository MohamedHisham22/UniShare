import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/explore_recently_view/cubit/search_explore_recently_view_cubit.dart';

class SearchRecentlyView extends StatefulWidget {
  const SearchRecentlyView({super.key});

  @override
  State<SearchRecentlyView> createState() => _SearchRecentlyViewState();
}

class _SearchRecentlyViewState extends State<SearchRecentlyView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
      controller: _controller,
      onChanged: (value) {
        context.read<SearchExploreRecentlyViewCubit>().recentlyView(value);
      },
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
          child:
              _controller.text.isNotEmpty
                  ? GestureDetector(
                    onTap: () {
                      _controller.clear();
                      context
                          .read<SearchExploreRecentlyViewCubit>()
                          .recentlyView('');
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Icon(Icons.clear, color: Colors.red),
                  )
                  : Icon(
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
