import 'package:employee_management/pages/home/components/attendance_company_time.dart';
import 'package:employee_management/pages/home/components/attendance_countdown.dart';
import 'package:employee_management/pages/home/components/attendance_time_notice.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';

class CardAttendanceTime extends StatelessWidget {
  const CardAttendanceTime({
    Key? key,
    required this.size,
    required this.dateFormat,
    required this.days,
  }) : super(key: key);

  final Size size;
  final String dateFormat;
  final String days;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: size.height * 0.16,
          width: size.width * .6,
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                // CURRENT DATE WIDGET
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.01, left: 7, right: 5),
                      child: Container(
                        height: size.height * .03,
                        width: size.width * 0.2,
                        decoration: const BoxDecoration(
                          color: Color(0xFF008836),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                        ),
                        child: Center(
                          child: Text(
                            days,
                            style: const TextStyle(
                                color: kPrimaryColor,
                                fontFamily: "RobotoRegular",
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: size.height * 0.01, left: 7, right: 5),
                      child: Container(
                        height: size.height * .03,
                        width: size.width * 0.33,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(196, 196, 196, 1),
                                width: 1)),
                        child: Center(
                          child: Text(
                            dateFormat.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "RobotoRegular",
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                // ATTENDANCE TIME
                Row(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 7, right: 5),
                      child: AttendanceCompanyTime(
                        size: size,
                        eclipse: 'eclipse_green.png',
                        time: '09.00',
                        timeType: 'Jam Masuk',
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 7, right: 5),
                      child: AttendanceCompanyTime(
                        size: size,
                        eclipse: 'eclipse_red.png',
                        time: '18.00',
                        timeType: 'Jam Keluar',
                      ),
                    )
                  ],
                ),

                // ATTENDANCE NOTICE
                // USING CONDITIONAL HERE
                const AttendanceTimeNotice()
              ],
            ),
            margin: EdgeInsets.only(right: size.width * .01),
          ),
        ),
        SizedBox(
          height: size.height * 0.16,
          width: size.width * .33,
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: const AttendanceCountdown(),
          ),
        ),
      ],
    );
  }
}
