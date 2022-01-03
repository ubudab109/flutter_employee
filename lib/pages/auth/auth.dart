// ignore_for_file: use_key_in_widget_constructors

import 'package:employee_management/pages/auth/components/ForgotPassword.dart';
import 'package:employee_management/pages/auth/components/input_text_auth.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Auth extends StatelessWidget {
  @override
  const Auth({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.1,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/company.png',
                width: size.width * 0.5,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              const InputTextAuth(label: 'No Hp/Email', isPassword: false),
              const InputTextAuth(label: 'Password', isPassword: true),
            ],
          ),
          ForgotPassword(),
          Container(
              padding: EdgeInsets.only(top: 10, left: size.width * 0.7),
              child: ElevatedButton(
                child: Text('Masuk'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(25, 200, 255, 1),
                    textStyle: const TextStyle(
                        fontFamily: 'RobotoRegular',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              )),
          SizedBox(
            height: size.height * 0.05,
          ),
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              'assets/svg/xxxx.svg',
              fit: BoxFit.fill,
              width: size.width * 1
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
          )
        ],
      ),
    );
  }
}
