import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';
import 'package:unishare/screens/login_view/widgets/auth_button.dart';
import 'package:unishare/screens/login_view/widgets/auth_info.dart';
import 'package:unishare/screens/login_view/widgets/auth_question.dart';
import 'package:unishare/screens/login_view/widgets/auth_textfield.dart';
import 'package:unishare/screens/login_view/widgets/auth_title.dart';
import 'package:unishare/screens/login_view/widgets/divider.dart';
import 'package:unishare/screens/login_view/widgets/google_signin.dart';
import 'package:unishare/screens/signup_view/views/signup_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  static String id = '/login';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final cubit = context.read<LoginViewCubit>();

    return BlocConsumer<LoginViewCubit, LoginViewState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is LoginSuccess) {
          cubit.clearFields();
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          progressIndicator: CircularProgressIndicator(color: Colors.black),
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
                        AuthTitle(width: width, title: 'Sign in'),
                        SizedBox(height: height * 0.032),
                        AuthInfo(
                          width: width,
                          text: 'Sign in with one of the following options',
                        ),
                        SizedBox(height: height * 0.032),
                        GestureDetector(
                          onTap: () {
                            cubit.signInWithGoogle(context: context);
                          },
                          child: GoogleSignIn(height: height, width: width),
                        ),
                        AuthDivider(height: height),
                        AuthTextField(
                          height: height,
                          width: width,
                          hintText: 'Email',
                          isThisAPassword: false,
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
                        SizedBox(height: height * 0.05),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.signIn(
                                context: context,
                                email: cubit.emailController.text,
                                password: cubit.passwordController.text,
                              );
                            }
                          },
                          child: AuthButton(
                            height: height,
                            width: width,
                            text: 'Sign in',
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        AuthQuestion(
                          width: width,
                          route: SignupView.id,
                          question: 'Dont\'t have an account?',
                          textButton: 'Sign up',
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
