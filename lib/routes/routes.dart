// ignore_for_file: prefer_const_constructors

import 'package:employee_management/pages/home/home.dart';
import 'package:employee_management/pages/profile/profile.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeMain());
      case '/home2':
        return MaterialPageRoute(builder: (_) => HomeTwo());
      case '/home3':
        return MaterialPageRoute(builder: (_) => Profile());
      default:
        throw Exception('Invalid Route : ${settings.name}');
    }
  }
}
