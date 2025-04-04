import 'package:flutter/material.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:unishare/screens/update_profile/widgets/changing_pictures.dart';
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
          Container(width: double.infinity),
        ],
      ),
    );
  }
}
