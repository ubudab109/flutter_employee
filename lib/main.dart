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
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        Widget child;
        // Show splash screen while waiting for app resources to load:
         if (snapshot.connectionState == ConnectionState.waiting) {
           child = MaterialApp(home: Splashscreen());
         } else {
           // Loading is done, return the app:
           child = MaterialApp(
             title: 'Employee Management Attendence',
             debugShowCheckedModeBanner: false,
             theme: ThemeData(
               backgroundColor: kPrimaryColor,
               primaryColor: kPrimaryColor
             ),
             home: Scaffold(
               resizeToAvoidBottomInset: false,
               body: Auth(),
             ),
           );
         }
        return AnimatedSwitcher(
          duration: Duration(seconds: 3),
          transitionBuilder: (Widget child, Animation<double> animation)  {
            return ScaleTransition(scale: animation, child: child);
          },
          child: child,
        );
      },
    );
  }
}



class Init {
  Init._();
  static final instance = Init._();
  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 3));
  }
}
