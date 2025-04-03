import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/home_view/cubit/get_items_cubit.dart';
import 'package:unishare/screens/home_view/cubit/home_cubit_cubit.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginViewCubit>();
    final cubit = context.read<HomeCubit>();
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            cubit.getImageFromGallery();
          },
          child: BlocBuilder<HomeCubit, HomeCubitState>(
            builder: (context, state) {
              return CircleAvatar(
                radius: width * 0.12,
                backgroundImage:
                    cubit.selectedImage == null
                        ? AssetImage(imagePath + 'User image.png')
                        : FileImage(cubit.selectedImage!),
              );
            },
          ),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey Alice',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: Color(0xffFF5A5F),
              ),
            ),
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Icon(Icons.menu, size: 33),
        ),
      ],
    );
  }
}
