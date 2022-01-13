import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:employee_management/pages/home/home.dart';
import 'package:employee_management/pages/profile/profile.dart';
import 'package:employee_management/routes/routes.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  void onTapNav(BuildContext context, int index) {
    switch (index) {
      case 0:
        _navigatorKey.currentState!.push<void>(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomeMain(),
          ),
        );
        break;
      case 1:
        _navigatorKey.currentState!.push<void>(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomeTrhee(),
          ),
        );
        break;
      case 2:
        _navigatorKey.currentState!.push<void>(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const Profile(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: themePrimayColor,
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
      bottomNavigationBar: ConvexAppBar(
        height: MediaQuery.of(context).size.height * 0.08,
        backgroundColor: kBluePrimary,
        style: TabStyle.react,
        top: -16,
        items: [
          TabItem(icon: SvgPicture.asset('assets/svg/HomeS.svg')),
          TabItem(icon: SvgPicture.asset('assets/svg/Scan Icon.svg')),
          TabItem(icon: SvgPicture.asset('assets/svg/Profile.svg')),
        ],
        initialActiveIndex: 0,
        onTap: (int i) => onTapNav(context, i),
      ),
    );
  }
}
