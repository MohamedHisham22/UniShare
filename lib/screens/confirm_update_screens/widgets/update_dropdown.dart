import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/update_profile/cubit/update_profile_cubit.dart';

class UpdateDropdown extends StatefulWidget {
  UpdateDropdown({
    required this.width,
    required this.height,
    required this.fieldValidation,
  });

  final double width;
  final double height;
  final FormFieldValidator<String> fieldValidation;

  @override
  State<UpdateDropdown> createState() => _AuthDropdownState();
}

class _AuthDropdownState extends State<UpdateDropdown> {
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
    final cubit = context.read<UpdateProfileCubit>();
    return DropdownButtonFormField(
      validator: widget.fieldValidation,
      decoration: InputDecoration(
        hintText: 'Location',
        hintStyle: TextStyle(color: const Color.fromARGB(255, 111, 111, 111)),
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.height * 0.02,
          horizontal: widget.width * 0.05,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 0),
        ),

        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        fillColor: const Color.fromARGB(255, 220, 220, 220),
        filled: true,
      ),
      menuMaxHeight: 600,
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
