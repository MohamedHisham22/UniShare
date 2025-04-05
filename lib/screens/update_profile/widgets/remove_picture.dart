import 'package:flutter/material.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:unishare/screens/update_profile/widgets/alert_dialog.dart';

class RemovePictureButton extends StatelessWidget {
  const RemovePictureButton({
    super.key,
    required this.cubit,
    required this.userID,
  });

  final UpdateProfileCubit cubit;
  final String userID;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return RemovePictureAlertDialog(cubit: cubit, userID: userID);
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          width: 170,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              'remove picture',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
