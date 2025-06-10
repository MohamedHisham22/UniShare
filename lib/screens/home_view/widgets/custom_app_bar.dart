import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';
import 'package:unishare/screens/login_view/model/user_model.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<UserModel>('userBox');
    final storedUser = userBox.get('user');

    if (storedUser != null) {
      context.read<LoginViewCubit>().userModel = storedUser;
    }
    final width = MediaQuery.of(context).size.width;
    final cubit = context.read<UpdateProfileCubit>();

    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      builder: (context, state) {
        return Row(
          children: [
            CircleAvatar(
              radius: width * 0.12,
              backgroundImage:
                  cubit.gettingImage.profileImage != null
                      ? NetworkImage(cubit.gettingImage.profileImage!)
                      : AssetImage(imagePath + 'User image.png'),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<LoginViewCubit, LoginViewState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Text(
                          'Hey ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : kPrimaryColor,
                          ),
                        ),
                        Text(
                          context.read<LoginViewCubit>().userModel?.firstName ??
                              'Loading',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : kPrimaryColor,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 20,
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
      },
    );
  }
}
