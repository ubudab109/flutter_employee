import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
          top: 10,
          left: size.width * 0.6
      ),
      child: RichText(
        textAlign: TextAlign.start,
        text: const TextSpan(
            style: TextStyle(
                fontFamily: 'RobotoRegular',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color.fromRGBO(0, 0, 0, 1)
            ),
            text: 'Forgot ',
            children: <TextSpan>[
              TextSpan(
                text: 'Password?',
                style: TextStyle(
                    fontFamily: 'RobotoRegular',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color.fromRGBO(25, 200, 255, 1)
                ),
              )
            ]
        ),
      ),
    );
  }
}
