import 'package:flutter/material.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key, required this.cubit});

  final UpdateProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cubit.cancelUpdatingProfilePicture();
      },
      child: Container(
        width: 160,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
