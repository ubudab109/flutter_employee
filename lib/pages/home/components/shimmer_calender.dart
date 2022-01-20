import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';

class ShimmerCalendarLoading extends StatelessWidget {
  const ShimmerCalendarLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: kPrimaryColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, left: size.width * .04, right: 5),
            child: const Text(
              'Pengingat',
              style: TextStyle(
                  fontFamily: 'RobotoRegular',
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 2, left: 7, right: 5),
          //     child: Align(
          //       alignment: Alignment.topRight,
          //       child: Container(),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
