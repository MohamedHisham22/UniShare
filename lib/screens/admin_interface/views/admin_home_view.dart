import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/admin_interface/views/tool_details_view_admin.dart';
import 'package:unishare/screens/home_view/cubit/get_items_cubit.dart';
import 'package:unishare/screens/home_view/models/get_items_model/get_items_model.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  static String id = '/AdminHomeView';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetItemsCubit>();
    final itemDetailesCubit = context.read<ToolDetailesClientViewCubit>();
    final loginCubit = context.read<LoginViewCubit>();
    String userID = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin Interface'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                loginCubit.signOut(context: context);
              },
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: BlocBuilder<GetItemsCubit, GetItemsCubitState>(
        builder: (context, state) {
          if (state is GetItemsCubitLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetItemsCubitError) {
            return Center(child: Text("Error: ${state.error}"));
          } else if (state is GetItemsCubitSuccess) {
            if (cubit.itemsList.isEmpty) {
              return const Center(child: Text("No items available."));
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: cubit.itemsList.length,
                itemBuilder: (context, index) {
                  GetItemsModel item = cubit.itemsList[index];
                  return GestureDetector(
                    onTap: () async {
                      await itemDetailesCubit.showItemDetailes(
                        itemID: item.itemId!,
                        userID: userID,
                      );
                      Navigator.pushNamed(context, ToolDetailsViewAdmin.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(41, 0, 0, 0),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[800]
                                : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image container
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.network(
                                  item.imageUrl ?? 'assets/images/tools.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey[600],
                                        size: 40,
                                      ),
                                    );
                                  },
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey[300],
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          value:
                                              loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          // Text container
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.itemName ?? 'Unnamed Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: Text("Unknown state"));
        },
      ),
    );
  }
}
