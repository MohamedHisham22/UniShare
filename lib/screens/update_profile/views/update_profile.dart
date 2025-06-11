import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:unishare/screens/update_profile/widgets/upadte_profile_view_body.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});
  static String id = 'updateProfile';
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateProfileCubit>();
    final String userID = FirebaseAuth.instance.currentUser?.uid ?? '';
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdatingImageFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(state.messege),
            ),
          );
        } else if (state is ProfilePicUpdateCanceled) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(state.messege),
            ),
          );
        } else if (state is UpdatingImageSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 44, 102, 46),
              behavior: SnackBarBehavior.floating,
              content: Text(state.messege),
            ),
          );
        } else if (state is DeletingProfileImageFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(state.messege),
            ),
          );
        } else if (state is DeletingProfileImageSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 44, 102, 46),
              behavior: SnackBarBehavior.floating,
              content: Text(state.messege),
            ),
          );
        }
      },
      builder: (context, state) {
        final String? profileImage = cubit.gettingImage.profileImage;

        return ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(color: Colors.black),
          inAsyncCall:
              state is UpdatingImageLoading ||
              state is DeletingProfileImageLoading,
          child: Scaffold(
            body: UpdateProfileViewBody(
              cubit: cubit,
              profileImage: profileImage,
              userID: userID,
            ),
          ),
        );
      },
    );
  }
}
