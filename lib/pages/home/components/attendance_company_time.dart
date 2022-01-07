import 'package:flutter/material.dart';

class AttendanceCompanyTime extends StatelessWidget {
  const AttendanceCompanyTime({
    Key? key,
    required this.size,
    required this.eclipse,
    required this.timeType,
    required this.time,
  }) : super(key: key);

  final Size size;
  final String eclipse;
  final String timeType;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          timeType,
          style: const TextStyle(
              fontFamily: 'RobotoRegular',
              fontSize: 13,
              fontWeight: FontWeight.w600),
        ),
        Container(
          margin: EdgeInsets.only(top: size.height * .01),
          width: size.width * 0.2,
          decoration: BoxDecoration(
              color: const Color(0XFFFFFFFF),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('assets/images/$eclipse'),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(time,
                    style: const TextStyle(
                        fontFamily: 'RobotoRegular',
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
