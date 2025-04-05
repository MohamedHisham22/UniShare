import 'package:flutter/material.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';

class RemovePictureAlertDialog extends StatelessWidget {
  const RemovePictureAlertDialog({
    super.key,
    required this.cubit,
    required this.userID,
  });

  final UpdateProfileCubit cubit;
  final String userID;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove Profile Picture'),
      content: const Text(
        'Are you sure you want to remove your profile picture?',
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Remove'),
          onPressed: () {
            cubit.deleteProfilePicture(userID: userID);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
