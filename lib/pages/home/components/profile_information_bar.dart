// ignore_for_file: prefer_const_constructors

import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';

class ProfileInformationBar extends StatelessWidget {
  final String fullname;
  final String role;
  final String nip;
  const ProfileInformationBar({
    Key? key,
    required this.fullname,
    required this.role,
    required this.nip
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            fullname,
            style: const TextStyle(
                fontFamily: 'RobotoMedium',
                color: kPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            role,
            style: const TextStyle(
                fontFamily: 'RobotoMedium',
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            'NIP : $nip',
            style: TextStyle(
                fontFamily: 'RobotoMedium',
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
