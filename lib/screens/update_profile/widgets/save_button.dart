import 'package:flutter/material.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.cubit, required this.userID});

  final UpdateProfileCubit cubit;
  final String userID;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cubit.submitingProfilePictureChangesToDataBase(
          cubit.selectedImage!,
          userID,
        );
      },
      child: Container(
        width: 160,
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 57, 131, 59),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            'Save',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
