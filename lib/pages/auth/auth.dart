// ignore_for_file: use_key_in_widget_constructors

import 'package:employee_management/apps/provider/auth/auth_provider.dart';
import 'package:employee_management/pages/auth/components/forgot_password.dart';
import 'package:employee_management/pages/auth/components/input_text_auth.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  @override
  const Auth({
    Key? key,
  });

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  AuthProvider? authProvider;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kPrimaryColor,
        body: Consumer<AuthProvider>(
            builder: (BuildContext context, AuthProvider value, Widget? child) {
          authProvider = value;
          return SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: size.height * 1,
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      SizedBox(height: size.height * 0.1),
                      Center(
                        child: Image.asset(
                          'assets/images/company.png',
                          width: size.width * 0.5,
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      InputTextAuth(
                        label: 'No Hp/Email',
                        isPassword: false,
                        controller: value.credential,
                      ),
                      InputTextAuth(
                        label: 'Password',
                        isPassword: true,
                        controller: value.password,
                      ),
                      const ForgotPassword(),
                      Container(
                          padding:
                              EdgeInsets.only(top: 10, left: size.width * 0.7),
                          child: ElevatedButton(
                            child: Text(
                                value.loadingLogin ? 'Processing...' : 'Masuk'),
                            onPressed: value.loadingLogin
                                ? null
                                : () {
                                    value.login(context);
                                  },
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(25, 200, 255, 1),
                                textStyle: const TextStyle(
                                    fontFamily: 'RobotoRegular',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          )),
                      SizedBox(height: size.height * 0.05),
                      Expanded(
                        child: SvgPicture.asset(
                          'assets/svg/xxxx.svg',
                          fit: BoxFit.fill,
                          width: size.width * 1,
                          height: size.height * 1,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
