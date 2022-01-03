// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InputTextAuth extends StatelessWidget {

  const InputTextAuth({
    Key? key,
    this.isPassword = false,
    required this.label,
  });

  final bool isPassword;
  final String label;
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
          Container(
            height: 60,
            child: TextField(
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
