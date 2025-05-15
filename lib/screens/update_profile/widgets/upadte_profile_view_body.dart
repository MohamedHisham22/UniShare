import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/confirm_update_screens/views/changing_fname_view.dart';
import 'package:unishare/screens/confirm_update_screens/views/changing_lname_view.dart';
import 'package:unishare/screens/confirm_update_screens/views/changing_location.dart';
import 'package:unishare/screens/confirm_update_screens/views/changing_number_view.dart';
import 'package:unishare/screens/confirm_update_screens/views/confirming_email_update.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:unishare/screens/update_profile/widgets/changing_pictures.dart';
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
                canBeChangedInGoogleAccount: true,
                defaultAccNavigationrouteName: ChangingFnameView.id,
                googleAccNavigationrouteName: ChangingFnameView.id,
              ),
              Spacer(),
              ProfileField(
                title: 'Last Name',
                text: profileCubit.userModel?.lastName ?? '',
                size: 170,
                canBeChangedInGoogleAccount: true,
                defaultAccNavigationrouteName: ChangingLnameView.id,
                googleAccNavigationrouteName: ChangingLnameView.id,
              ),
            ],
          ),

          SizedBox(height: 16),
          ProfileField(
            title: 'Email',
            text: profileCubit.userModel?.email ?? "",
            size: double.infinity,
            canBeChangedInGoogleAccount: false,
            defaultAccNavigationrouteName: ConfirmingEmailUpdateView.id,
            googleAccNavigationrouteName: ConfirmingEmailUpdateView.id,
          ),
          SizedBox(height: 16),
          ProfileField(
            title: 'Phone Number',
            text: profileCubit.userModel?.phoneNumber ?? '',
            size: double.infinity,
            canBeChangedInGoogleAccount: true,
            defaultAccNavigationrouteName: ChangingPhoneNumberView.id,
            googleAccNavigationrouteName: ChangingPhoneNumberView.id,
          ),
          SizedBox(height: 16),
          ProfileField(
            title: 'Location',
            text: profileCubit.userModel?.location ?? '',
            size: double.infinity,
            canBeChangedInGoogleAccount: true,
            defaultAccNavigationrouteName: ChangingLocationView.id,
            googleAccNavigationrouteName: ChangingLocationView.id,
          ),
          SizedBox(height: 16),
          if (!isGoogleAccount)
            PasswordField(text: profileCubit.userModel?.password ?? ''),
        ],
      ),
    );
  }
}
