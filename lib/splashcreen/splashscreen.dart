import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.3,
            ),
            Center(
              child: Image.asset('assets/images/company.png'),
            ),

            SizedBox(
              height: size.height * 0.1,
            ),

            Expanded(
                child: SvgPicture.asset(
                  'assets/svg/xnxx.svg',
                  fit: BoxFit.fill,
                  width: size.width * 1,
                )
            ),
          ],
        ));
  }
}
