import 'package:employee_management/pages/auth/auth.dart';
import 'package:employee_management/splashcreen/splashscreen.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management Attendence',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: kPrimaryColor, primaryColor: kPrimaryColor),
      home: const Scaffold(
        backgroundColor: kPrimaryColor,
        body: Splashscreen(),
      ),
    );
  }
}
