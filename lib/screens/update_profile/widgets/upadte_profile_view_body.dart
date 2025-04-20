import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:unishare/screens/update_profile/widgets/changing_pictures.dart';
import 'package:unishare/screens/update_profile/widgets/dropdown_location_field.dart';
import 'package:unishare/screens/update_profile/widgets/password_field.dart';
import 'package:unishare/screens/update_profile/widgets/profile_field.dart';
import 'package:unishare/screens/update_profile/widgets/profile_picture.dart';
import 'package:unishare/screens/update_profile/widgets/remove_picture.dart';

class UpdateProfileViewBody extends StatelessWidget {
  const UpdateProfileViewBody({
    super.key,
    required this.cubit,
    required this.profileImage,
    required this.userID,
  });

  final UpdateProfileCubit cubit;
  final String? profileImage;
  final String userID;

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<LoginViewCubit>();
    final isGoogleAccount = profileCubit.userModel?.type == "google account";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          ProfilePicture(cubit: cubit, profileImage: profileImage),
          if (cubit.isImageChanged == false)
            RemovePictureButton(cubit: cubit, userID: userID),
          if (cubit.isImageChanged != false)
            ChangingPictureButtons(cubit: cubit, userID: userID),

          SizedBox(height: 15),

          Row(
            children: [
              ProfileField(
                title: 'First Name',
                text: profileCubit.userModel?.firstName ?? '',
                size: 170,
              ),
              Spacer(),
              ProfileField(
                title: 'Last Name',
                text: profileCubit.userModel?.lastName ?? '',
                size: 170,
              ),
            ],
          ),

          SizedBox(height: 16),
          ProfileField(
            title: 'Email',
            text: profileCubit.userModel?.email ?? "",
            size: double.infinity,
          ),
          SizedBox(height: 16),
          ProfileField(
            title: 'Phone Number',
            text: profileCubit.userModel?.phoneNumber ?? '',
            keyboardType: TextInputType.number,
            size: double.infinity,
          ),
          SizedBox(height: 16),
          LocationDropdownField(text: profileCubit.userModel?.location ?? ''),
          SizedBox(height: 16),
          if (!isGoogleAccount)
            PasswordField(text: profileCubit.userModel?.password ?? ''),
        ],
      ),
    );
  }
}
