import 'package:flutter/material.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';

class EditPictureButton extends StatelessWidget {
  const EditPictureButton({super.key, required this.cubit});

  final UpdateProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          cubit.updateProfilePicture();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.edit, color: Colors.white, size: 16),
          ),
        ),
      ),
    );
  }
}
