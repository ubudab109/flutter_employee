import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';

class AttendanceCountdown extends StatelessWidget {
  const AttendanceCountdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Waktu',
          style: TextStyle(
              fontFamily: 'RobotoRegular',
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        const Text(
          '00.00.00',
          style: TextStyle(
              fontFamily: 'RobotoMedium',
              fontSize: 17,
              fontWeight: FontWeight.w900),
        ),
        SizedBox(
          width: size.width * 0.27,
          height: size.height * .03,
          child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(kBluePrimary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
              ),
              child: const Text('Clock Out',
                  style: TextStyle(
                      fontFamily: 'RobotoRegular',
                      fontSize: 12,
                      fontWeight: FontWeight.w700))),
        )
      ],
    );
  }
}
