import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/confirm_update_screens/widgets/update_textformfield.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:unishare/screens/update_profile/views/update_profile.dart';

class ConfirmingEmailUpdateView extends StatelessWidget {
  ConfirmingEmailUpdateView({super.key});
  static final String id = 'confirmingEmailUpdate';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateProfileCubit>();

    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state is ChangingEmailFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(state.messege),
            ),
          );
        } else if (state is ChangingEmailSuccess) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: 'Success!',
            desc:
                'An email has been sent to you Please check your inbox to verify your new email and restart the application',
            btnOkOnPress: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, UpdateProfile.id);
            },
          ).show();
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ChangingEmailLoading,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                'Email',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryColor,
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
                      'Update Your Email',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '''Please enter your new email and your current password''',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: UpdateTextField(
                        fieldController: cubit.newEmailController,
                        hintText: 'New Email',
                        clearingFunction: cubit.clearingNewEmailTextField,
                        isPassword: false,
                        fieldValidator: cubit.validateNewEmail,
                      ),
                    ),
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
                            cubit.changeEmail(
                              currentPassword:
                                  cubit.currentPasswordController.text,
                              newEmail: cubit.newEmailController.text,
                            );
                            cubit.newEmailController.clear();
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
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                              fontSize: 18,
                            ),
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
