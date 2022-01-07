import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';

class ProfileInformationBar extends StatelessWidget {
  const ProfileInformationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            'Angela san andreas',
            style: TextStyle(
                fontFamily: 'RobotoRegular',
                color: kPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            'Manager',
            style: TextStyle(
                fontFamily: 'RobotoRegular',
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            'NIP : 0215445545',
            style: TextStyle(
                fontFamily: 'RobotoRegular',
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
