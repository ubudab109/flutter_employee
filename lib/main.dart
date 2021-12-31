import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        return const MaterialApp(home: Splash());
        // Show splash screen while waiting for app resources to load:
        // if (snapshot.connectionState == ConnectionState.waiting) {

        // } else {
        //   // Loading is done, return the app:
        //   return MaterialApp(
        //     title: 'Flutter Demo',
        //     theme: ThemeData(
        //       primarySwatch: Colors.blue,
        //     ),
        //     home: const Text('Hello World'),
        //   );
        // }
      },
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height / 2);

    
    // canvas.drawPath(path, paint);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.2,
              ),
              Center(
                child: Image.asset('assets/images/company.png'),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: ClipPath(
                    clipper: ClipPathClass(),
                    child: SizedBox(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(25, 200, 255, 1),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
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
