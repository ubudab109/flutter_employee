// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SelectedTime extends StatelessWidget {
  const SelectedTime({Key? key, required this.hour, required this.minute})
      : super(key: key);

  final String hour;
  final String minute;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          hour,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'RobotoMedium',
              fontWeight: FontWeight.w500),
        ),
        Text(
          ':',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'RobotoMedium',
              fontWeight: FontWeight.w500),
        ),
        Text(
          minute,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'RobotoMedium',
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}