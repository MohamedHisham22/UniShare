import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/login_view/cubit/login_view_cubit.dart';

class ProfileField extends StatelessWidget {
  final String title;
  final String text;
  final TextInputType? keyboardType;
  final double size;
  final bool canBeChangedInGoogleAccount;
  final String googleAccNavigationrouteName;
  final String defaultAccNavigationrouteName;

  const ProfileField({
    Key? key,
    required this.title,
    required this.text,
    required this.size,
    this.keyboardType,
    required this.canBeChangedInGoogleAccount,
    required this.googleAccNavigationrouteName,
    required this.defaultAccNavigationrouteName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<LoginViewCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: size,
          decoration: BoxDecoration(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Color(0xffEAEAEA),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(text, style: const TextStyle(fontSize: 16)),
              ),
              const Spacer(),

              if (profileCubit.userModel?.type == "default account")
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () {
                    Navigator.pushNamed(context, defaultAccNavigationrouteName);
                  },
                ),
              if (profileCubit.userModel?.type == "google account")
                canBeChangedInGoogleAccount
                    ? IconButton(
                      icon: Icon(Icons.edit, size: 20),

                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          googleAccNavigationrouteName,
                        );
                      },
                    )
                    : IconButton(
                      onPressed: () {},
                      icon: Icon(null),

                      highlightColor: Colors.transparent,
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
