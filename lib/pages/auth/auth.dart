import 'package:employee_management/pages/auth/components/ForgotPassword.dart';
import 'package:employee_management/pages/auth/components/InputTextAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Auth extends StatelessWidget {
  @override
  const Auth({
    Key? key,
//    required this.child
  });

//  final Widget child;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.1,
          ),
          Center(
            child: Image.asset(
              'assets/images/company.png',
              width: size.width * 0.5,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),

          Column(
            children: <Widget>[
              InputTextAuth(label: 'No Hp/Email', isPassword: false),
              InputTextAuth(label: 'Password', isPassword: true),
            ],
          ),
          ForgotPassword(),
          Container(
            padding: EdgeInsets.only(
                top: 10,
                left: size.width * 0.7
            ),
            child: ElevatedButton(
              child: Text('Masuk'),
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(25, 200, 255, 1),
                textStyle: TextStyle(
                    fontFamily: 'RobotoRegular',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color.fromRGBO(255, 255, 255, 1)
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            )
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Expanded(
            child: SvgPicture.asset(
              'assets/svg/xxxx.svg',
              fit: BoxFit.fill,
              width: size.width * 1,
            ),
          )

        ],
      ),
    );
  }
}
