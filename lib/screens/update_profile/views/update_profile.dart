import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});
  static String id = 'updateProfile';
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateProfileCubit>();

    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdatingImageFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.messege)));
        } else if (state is ProfilePicUpdateCanceled) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.messege)));
        } else if (state is UpdatingImageSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 44, 102, 46),
              content: Text('Image Updated Successfully!'),
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is UpdatingImageLoading,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            cubit.selectedImage != null
                                ? FileImage(cubit.selectedImage!)
                                : (cubit.gettingImage.profileImage != null
                                    ? NetworkImage(
                                      cubit.gettingImage.profileImage!,
                                    )
                                    : AssetImage(imagePath + 'User image.png')),
                      ),
                      Positioned(
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
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (cubit.isImageChanged != false)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.submitingProfilePictureChangesToDataBase(
                                cubit.selectedImage!,
                                FirebaseAuth.instance.currentUser?.uid ?? '',
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
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
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
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Container(width: double.infinity),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
