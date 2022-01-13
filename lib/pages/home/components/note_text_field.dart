import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';

class NoteTextField extends StatelessWidget {
  const NoteTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
      hintText: 'Tulis Catatan...',
      hintStyle: const TextStyle(
        fontFamily: 'RobotoRegular',
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      suffixIcon: IconButton(
        onPressed: () {},
        icon: Image.asset('assets/images/plus_square.png'),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: kPrimaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: kPrimaryColor),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor)),
      filled: true,
      fillColor: kPrimaryColor,
    ));
  }
}
