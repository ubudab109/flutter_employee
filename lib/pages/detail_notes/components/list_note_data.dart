// ignore_for_file: prefer_const_constructors

import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';

class ListNoteData extends StatelessWidget {
  final String color;
  final String time;
  final String note;
  final GestureTapCallback? onTap;
  const ListNoteData({
    Key? key, required this.color, required this.time, required this.note, this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: kPrimaryColor,
          border: Border(
            left: BorderSide(
                style: BorderStyle.solid, width: 20, color: Color(int.parse(color))),
          )),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Image.asset(
                'assets/images/coolicon.png',
                height: 20,
                width: 20,
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                fontFamily: 'RobotoRegular',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            note,
            style: const TextStyle(
                fontFamily: 'RobotoRegular',
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
        ),
        dense: true,
        contentPadding: EdgeInsets.all(20),
        trailing: GestureDetector(
          onTap: onTap,
          child: Image.asset('assets/images/Delete.png')
        ),
      ),
    );
  }
}