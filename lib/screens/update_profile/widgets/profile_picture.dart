import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:unishare/screens/update_profile/widgets/edit_picture_button.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.cubit,
    required this.profileImage,
  });

  final UpdateProfileCubit cubit;
  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage:
              cubit.selectedImage != null
                  ? FileImage(cubit.selectedImage!)
                  : (profileImage != null
                      ? NetworkImage(cubit.gettingImage.profileImage!)
                      : AssetImage(imagePath + 'User image.png')),
        ),
        EditPictureButton(cubit: cubit),
      ],
    );
  }
}
