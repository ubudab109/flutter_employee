// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class InputTextAuth extends StatelessWidget {

  const InputTextAuth({
    Key? key,
    this.isPassword = false,
    required this.label,
    this.validator,
    this.onChanged,
    this.controller
  });

  final bool isPassword;
  final String label;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: size.width * 0.02
            ),
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: const TextStyle(
                height: 2,
                fontFamily: 'RobotoRegular',
                fontWeight: FontWeight.w700,
                fontSize: 14
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              validator: validator,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(229, 229, 229, 1)
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(229, 229, 229, 1)
                      )
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(229, 229, 229, 1)
                    )
                  ),
                  filled: true,
                  fillColor: const Color.fromRGBO(229, 229, 229, 1)
              ),
              obscureText: isPassword,
            ),
          ),
        ],
      ),
    );
  }
}
