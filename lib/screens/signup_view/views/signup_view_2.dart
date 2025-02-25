import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unishare/screens/login_view/views/login_view.dart';
import 'package:unishare/screens/login_view/widgets/auth_button.dart';
import 'package:unishare/screens/login_view/widgets/auth_info.dart';
import 'package:unishare/screens/login_view/widgets/auth_question.dart';
import 'package:unishare/screens/login_view/widgets/auth_textfield.dart';
import 'package:unishare/screens/login_view/widgets/auth_title.dart';
import 'package:unishare/screens/signup_view/cubit/signup_view_cubit.dart';

class SignupView2 extends StatelessWidget {
  SignupView2({super.key});

  static String id = '/signup2';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final cubit = context.read<SignupViewCubit>();
    return BlocConsumer<SignupViewCubit, SignupViewState>(
      listener: (context, state) {
        if (state is SignupFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading,
          child: Scaffold(
            body: Form(
              key: _formKey,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: width * 0.085,
                    left: width * 0.085,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.12),
                        AuthTitle(width: width, title: 'Sign up'),
                        SizedBox(height: height * 0.032),
                        AuthInfo(
                          width: width,
                          text: 'please fillup the following information',
                        ),
                        SizedBox(height: height * 0.032),
                        AuthTextField(
                          height: height,
                          width: width,
                          hintText: 'Email',
                          fieldController: cubit.emailController,
                          fieldValidation: cubit.validateEmail,
                        ),

                        SizedBox(height: height * 0.032),
                        AuthTextField(
                          height: height,
                          width: width,
                          hintText: 'Password',
                          isThisAPassword: true,
                          fieldController: cubit.passwordController,
                          fieldValidation: cubit.validatePassword,
                        ),
                        SizedBox(height: height * 0.032),
                        AuthTextField(
                          height: height,
                          width: width,
                          hintText: 'Confirm Pasword',
                          isThisAPassword: true,
                          fieldValidation: cubit.validateConfirmPassword,
                        ),

                        SizedBox(height: height * 0.05),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.signUp(
                                context: context,
                                email: cubit.emailController.text,
                                password: cubit.passwordController.text,
                                firstName: cubit.firstNameController.text,
                                lastName: cubit.lastNameController.text,
                                phone: cubit.phoneNumberController.text,
                                location: cubit.selectedLocation!,
                              );
                            }
                          },
                          child: AuthButton(
                            height: height,
                            width: width,
                            text: 'Sign up',
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        AuthQuestion(
                          width: width,
                          route: LoginView.id,
                          question: 'Already have an account?',
                          textButton: 'Sign in',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
