import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/custom_bottom_nav_bar.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/tool_details_view_client_body.dart';

class ToolDetailsViewClient extends StatelessWidget {
  static String id = '/toolDetailsClient';
  const ToolDetailsViewClient({super.key});

  @override
  Widget build(BuildContext context) {
    final itemsDetailCubit = context.read<ToolDetailesClientViewCubit>();
    return BlocConsumer<
      ToolDetailesClientViewCubit,
      ToolDetailesClientViewState
    >(
      listener: (context, state) {
        if (state is GettingItemDetailesFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.red, content: Text(state.massege)),
          );
        }
      },
      builder: (context, state) {
        if (state is GettingItemDetailesLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(
            body: ToolDetailsViewClientBody(),
            bottomNavigationBar: CustomBottomNavigationBar(
              itemsDetailCubit: itemsDetailCubit,
            ),
          );
        }
      },
    );
  }
}
