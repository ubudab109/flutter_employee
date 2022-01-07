import 'package:flutter/material.dart';

class AttendanceTimeNotice extends StatelessWidget {
  const AttendanceTimeNotice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 7, right: 5),
          child: Image.asset('assets/images/speaker.png'),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, left: 1, right: 5),
          child: Text(
            'Silahkan Absen Terlebih Dahulu',
            style: TextStyle(
                color: Colors.red,
                fontFamily: 'RobotoRegular',
                fontWeight: FontWeight.w600,
                fontSize: 12),
          ),
        )
      ],
    );
  }
}
