import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/confirm_update_screens/widgets/update_dropdown.dart';
import 'package:unishare/screens/confirm_update_screens/widgets/update_textformfield.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:unishare/screens/update_profile/views/update_profile.dart';

class ChangingLocationView extends StatelessWidget {
  ChangingLocationView({super.key});
  static final String id = 'ChangingLocation';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateProfileCubit>();
    final profileCubit = context.read<LoginViewCubit>();
    final isGoogleAccount = profileCubit.userModel?.type == "google account";
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state is ChangingLocationFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.messege)));
        } else if (state is ChangingLocationSuccess) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: 'Success!',
            desc: 'Your Location Has been Updated Successfully!',
            btnOkOnPress: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, UpdateProfile.id);
            },
          ).show();
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ChangingLocationLoading,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                'Location',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),

            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Update Your Location',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '''Please enter your new location and your current password''',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: UpdateDropdown(
                        width: width,
                        height: height,
                        fieldValidation: cubit.validateNewLocation,
                      ),
                    ),
                    if (!isGoogleAccount)
                      UpdateTextField(
                        fieldController: cubit.currentPasswordController,
                        hintText: 'your password',
                        clearingFunction: cubit.clearingPasswordTextField,
                        isPassword: true,
                        fieldValidator: cubit.validateCurrentPassword,
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.changeLocation(
                              location: cubit.selectedLocation!,
                              password: cubit.currentPasswordController.text,
                            );
                            cubit.selectedLocation = '';
                            cubit.currentPasswordController.clear();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kPrimaryColor,
                          ),
                          child: Center(
                            child: Text(
                              'Submit Change',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        cubit.newEmailController.clear();
                        cubit.currentPasswordController.clear();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
