import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/saved_view/cubit/favorite_items_cubit_cubit.dart';
import 'package:unishare/screens/saved_view/widgets/saved_view_body.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});
  static String id = '/saved';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteItemsCubit, FavoriteItemsState>(
      listener: (context, state) {
        if (state is GettingFavoritesFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text(state.massege),
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is GettingFavoritesLoading,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 85,
              title: Text(
                'Liked items',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryColor,
                ),
              ),
              centerTitle: true,
            ),
            body: SavedViewBody(),
          ),
        );
      },
    );
  }
}
