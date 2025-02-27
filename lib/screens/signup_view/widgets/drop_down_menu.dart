import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/signup_view/cubit/signup_view_cubit.dart';

class AuthDropdown extends StatefulWidget {
  AuthDropdown({
    required this.width,
    required this.height,
    required this.fieldValidation,
  });

  final double width;
  final double height;
  final FormFieldValidator<String> fieldValidation;

  @override
  State<AuthDropdown> createState() => _AuthDropdownState();
}

class _AuthDropdownState extends State<AuthDropdown> {
  String? selectedValue;

  final List<String> dropdownItems = [
    'القاهرة',
    'الجيزة',
    'الإسكندرية',
    'الزقازيق',
    'المنصورة',
    'دمنهور',
    'المنيا',
    'بنها',
    'سوهاج',

    'طنطا',
    'أسيوط',
    'شبين الكوم',
    'الفيوم',
    'كفر الشيخ',
    'قنا',
    'بني سويف',
    'أسوان',
    'دمياط',
    'الإسماعيلية',
    'الأقصر',
    'السويس',
    'بورسعيد',
    'مرسى مطروح',
    'العريش',
    'الغردقة',
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupViewCubit>();
    return DropdownButtonFormField(
      validator: widget.fieldValidation,
      decoration: InputDecoration(
        hintText: 'Location',
        hintStyle: const TextStyle(color: Color.fromARGB(255, 102, 101, 101)),
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.height * 0.02,
          horizontal: widget.width * 0.05,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      value: selectedValue,
      items:
          dropdownItems.map((String item) {
            return DropdownMenuItem(
              value: item,
              alignment: Alignment.centerRight,
              child: Text(item),
            );
          }).toList(),
      onChanged: (value) {
        cubit.setLocation(value!); // Save the selected location in the cubit
      },
    );
  }
}
