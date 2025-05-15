import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/confirm_update_screens/widgets/update_textformfield.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';

class ConfirmingPasswordUpdateView extends StatelessWidget {
  ConfirmingPasswordUpdateView({super.key});
  static final String id = 'confirmingPasswordUpdate';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateProfileCubit>();
    final loginCubit = context.read<LoginViewCubit>();
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state is ChangingPasswordFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.messege)));
        } else if (state is ChangingPasswordSuccess) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: 'Success!',
            desc: 'Your Password Has Been Changed Successfully!',
            btnOkOnPress: () {
              loginCubit.signOut(context: context);
            },
          ).show();
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ChangingPasswordLoading,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                'Password',
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
                      'Update Your Password',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '''Please enter your new password and your current password''',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: UpdateTextField(
                        fieldController: cubit.currentPasswordController,
                        hintText: 'Current Password',
                        clearingFunction: cubit.clearingPasswordTextField,
                        isPassword: true,
                        fieldValidator: cubit.validateCurrentPassword,
                      ),
                    ),
                    UpdateTextField(
                      fieldController: cubit.newPasswordController,
                      hintText: 'New Password',
                      clearingFunction: cubit.clearingNewPasswordTextField,
                      isPassword: true,
                      fieldValidator: cubit.validateNewPassword,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: UpdateTextField(
                        fieldController: cubit.confirmNewPasswordController,
                        hintText: 'Confirm Password',
                        clearingFunction:
                            cubit.clearingConfirmNewPasswordTextField,
                        isPassword: true,
                        fieldValidator: cubit.validateConfirmPassword,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.changePassword(
                              currentPassword:
                                  cubit.currentPasswordController.text,
                              newPassword: cubit.newPasswordController.text,
                            );
                            cubit.currentPasswordController.clear();
                            cubit.newPasswordController.clear();
                            cubit.confirmNewPasswordController.clear();
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
                        cubit.currentPasswordController.clear();
                        cubit.newPasswordController.clear();
                        cubit.confirmNewPasswordController.clear();
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
