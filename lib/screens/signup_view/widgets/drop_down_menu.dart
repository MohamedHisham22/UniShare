import 'package:flutter/material.dart';
import 'package:unishare/constants.dart';

class AuthDropdown extends StatefulWidget {
  AuthDropdown({required this.width, required this.height});

  final double width;
  final double height;

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
    'الإسكندرية',
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
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: 'Location',
        hintStyle: const TextStyle(color: Color.fromARGB(255, 102, 101, 101)),
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.height * 0.02,
          horizontal: widget.width * 0.05,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor),
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
        setState(() {
          selectedValue = value;
        });
      },
    );
  }
}
