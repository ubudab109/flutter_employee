import 'package:flutter/material.dart';

class AttendanceTimeNotice extends StatelessWidget {
  const AttendanceTimeNotice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        right: size.width * 0.1,
        top: size.height * 0.01
      ),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: const TextStyle(
          color: Colors.red,
          fontFamily: 'RobotoRegular',
          fontWeight: FontWeight.w600,
          fontSize: 12
          ),
          children: [
          WidgetSpan(
            child: Image.asset('assets/images/speaker.png'),
          ),
          const TextSpan(
            text: "Silahkan Absen Terlebih Dahulu",
          ),
        ]),
      ),
    );
  }
}