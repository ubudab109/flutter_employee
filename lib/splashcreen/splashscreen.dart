import 'package:employee_management/apps/my_app.dart';
import 'package:employee_management/apps/repository/auth_repository.dart';
import 'package:employee_management/pages/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  AuthRepository authRepository = AuthRepository();
  // String? token;
  String? token;

  Widget child = const Auth();

  getChild() async {
    var res = await authRepository.hasToken();
    if (res != null) {
      if (mounted) {
        setState(() {
          child = const MyApp();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getChild();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 2000),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
          height: size.height * 0.3,
        ),
        Center(
          child: Image.asset('assets/images/company.png'),
        ),
        SizedBox(
          height: size.height * 0.1,
        ),
        Expanded(
            child: SvgPicture.asset(
          'assets/svg/xnxx.svg',
          fit: BoxFit.fill,
          width: size.width * 1,
        )),
      ],
    );
  }
}
