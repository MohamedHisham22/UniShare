import 'package:flutter/material.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:unishare/screens/update_profile/widgets/cancel_button.dart';
import 'package:unishare/screens/update_profile/widgets/save_button.dart';

class ChangingPictureButtons extends StatelessWidget {
  const ChangingPictureButtons({
    super.key,
    required this.cubit,
    required this.userID,
  });

  final UpdateProfileCubit cubit;
  final String userID;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          SaveButton(cubit: cubit, userID: userID),
          Spacer(),
          CancelButton(cubit: cubit),
        ],
      ),
    );
  }
}
