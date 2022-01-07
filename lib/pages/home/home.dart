import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  void onTapNav(index) {
    switch (index) {
      case 0:
        _navigatorKey.currentState!.pushNamed('/');
        break;
      case 1:
        _navigatorKey.currentState!.pushNamed('/home2');
        break;
      case 2:
        _navigatorKey.currentState!.pushNamed('/home3');
        break;
    }
  }

  late String dateFormat;
  late String days;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    DateTime now = DateTime.now();
    dateFormat = DateFormat('dd/MM/yyyy', 'id_ID').format(now).toString();
    days = DateFormat('EEEE', 'id_ID').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_navigatorKey.currentState!.canPop()) {
            _navigatorKey.currentState!.pop();
            return false;
          }
          return true;
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext context) => HomeMain(
                      date: dateFormat,
                      days: days,
                    );
                break;
              case '/home2':
                builder = (BuildContext context) => const HomeTwo();
                break;
              case '/home3':
                builder = (BuildContext context) => const HomeTrhee();
                break;
              default:
                throw Exception('Invalid Route : ${settings.name}');
            }
            return MaterialPageRoute(
              builder: builder,
              settings: settings,
            );
          },
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        height: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: kBluePrimary,
        style: TabStyle.react,
        items: [
          TabItem(icon: SvgPicture.asset('assets/svg/HomeS.svg')),
          TabItem(icon: SvgPicture.asset('assets/svg/qrscans.svg')),
          TabItem(icon: SvgPicture.asset('assets/svg/Profile.svg')),
        ],
        initialActiveIndex: 0,
        onTap: (int i) => onTapNav(i),
      ),
    );
  }
}

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key, required this.date, required this.days})
      : super(key: key);

  final String date;
  final String days;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: size.height * 0.2,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF02b4eb),
                          Color(0xFFb4ecfe),
                        ],
                      )),
                  child: UserInformationWidget(size: size),
                ),
                Positioned(
                    top: size.height * 0.15,
                    left: size.width * .04,
                    child: CardAttendanceTime(
                      size: size,
                      dateFormat: date,
                      days: days,
                    )),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: size.height * 0.5,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      MenuIconHome(
                        onPressed: null,
                        icon: 'jadwal_kerja.png',
                        iconName: 'Jadwal Kerja',
                      ),
                      MenuIconHome(
                        onPressed: null,
                        icon: 'Gaji.png',
                        iconName: 'Gaji',
                      ),
                      MenuIconHome(
                        onPressed: null,
                        icon: 'Paidleave.png',
                        iconName: 'Request Jadwal',
                      ),
                      MenuIconHome(
                        onPressed: null,
                        icon: 'Bonus.png',
                        iconName: 'Bonus',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("List 2.1"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("List 2.2"),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class MenuIconHome extends StatelessWidget {
  const MenuIconHome({
    Key? key,
    this.onPressed,
    required this.iconName,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String iconName;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          iconSize: 50,
          icon: Image.asset('assets/images/$icon'),
          onPressed: () {},
        ),
        Text(
          iconName,
          style: const TextStyle(
              fontFamily: 'RobotoRegular',
              fontSize: 12,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}

class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size.width * 0.2,
          height: size.height * .07,
          decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(30))),
          child: Align(
            alignment: Alignment(size.width * .001, 0),
            child: Container(
                width: size.width * 0.1,
                height: size.height * 0.1,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://uselooper.com/docs/images/avatars/uifaces1.jpg")))),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: size.width * .05),
          child: const ProfileInformationBar(),
        ),
        Container(
            margin: EdgeInsets.only(left: size.width * 0.2),
            padding: EdgeInsets.only(bottom: size.height * .03),
            child: IconButton(
              icon: SvgPicture.asset('assets/svg/bell.svg'),
              onPressed: () {},
            ))
      ],
    );
  }
}

class ProfileInformationBar extends StatelessWidget {
  const ProfileInformationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            'Angela san andreas',
            style: TextStyle(
                fontFamily: 'RobotoRegular',
                color: kPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            'Manager',
            style: TextStyle(
                fontFamily: 'RobotoRegular',
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            'NIP : 0215445545',
            style: TextStyle(
                fontFamily: 'RobotoRegular',
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

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
          height: size.height * 0.18,
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
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: Container(
                        height: size.height * .03,
                        width: size.width * 0.2,
                        decoration: const BoxDecoration(
                          color: Color(0xFF008836),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
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
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Container(
                        height: size.height * .03,
                        width: size.width * 0.33,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(196, 196, 196, 1),
                                width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
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
                          const EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: AttendanceCompanyTime(
                        size: size,
                        eclipse: 'eclipse_green.png',
                        time: '09.00',
                        timeType: 'Jam Masuk',
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, right: 5),
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
          height: size.height * 0.18,
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

class AttendanceCountdown extends StatelessWidget {
  const AttendanceCountdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Waktu',
          style: TextStyle(
              fontFamily: 'RobotoRegular',
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        const Text(
          '00.00.00',
          style: TextStyle(
              fontFamily: 'RobotoRegular',
              fontSize: 17,
              fontWeight: FontWeight.w700),
        ),
        ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(kBluePrimary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ))),
            child: const Text('Clock Out',
                style: TextStyle(
                    fontFamily: 'RobotoRegular',
                    fontSize: 17,
                    fontWeight: FontWeight.w700)))
      ],
    );
  }
}

class AttendanceTimeNotice extends StatelessWidget {
  const AttendanceTimeNotice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Image.asset('assets/images/speaker.png'),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, left: 1, right: 5),
          child: Text(
            'Silahkan Absen Terlebih Dahulu',
            style: TextStyle(
                color: Colors.red,
                fontFamily: 'RobotoRegular',
                fontWeight: FontWeight.w600,
                fontSize: 12),
          ),
        )
      ],
    );
  }
}

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
                  spreadRadius: 5,
                  blurRadius: 7,
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

class HomeTwo extends StatelessWidget {
  const HomeTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.red),
        child: Text("TEST"),
      ),
    );
  }
}

class HomeTrhee extends StatelessWidget {
  const HomeTrhee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.blue),
      child: Text("Two"),
    );
  }
}
