import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:employee_management/pages/home/components/card_attendance_time.dart';
import 'package:employee_management/pages/home/components/menu_icon_home.dart';
import 'package:employee_management/pages/home/components/user_information.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

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
      backgroundColor: themePrimayColor,
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
        backgroundColor: themePrimayColor,
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              color: kPrimaryColor,
              height: size.height * 0.48,
              width: double.infinity,
              child: Stack(
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
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.05),
                          child: UserInformationWidget(size: size),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: size.height * 0.15,
                      left: size.width * .032,
                      child: CardAttendanceTime(
                        size: size,
                        dateFormat: date,
                        days: days,
                      )),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: size.height * 0.43,
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
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            // CALENDER
            Container(
              color: kPrimaryColor,
              height: size.height * 0.7,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 7, right: 5),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.all(8.0),
                        child: CalenderCompany(size: size),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class CalenderCompany extends StatefulWidget {
  const CalenderCompany({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<CalenderCompany> createState() => _CalenderCompanyState();
}

class _CalenderCompanyState extends State<CalenderCompany> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  double offsetShadow = 0;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'id_ID',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      startingDayOfWeek: StartingDayOfWeek.sunday,
      daysOfWeekVisible: true,
      headerStyle: const HeaderStyle(
          decoration: BoxDecoration(
            color: Color(0XFFFF6161),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          formatButtonVisible: false,
          titleCentered: true,
          formatButtonShowsNext: true,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          headerMargin: EdgeInsets.only(bottom: 10)),
      calendarFormat: format,
      onFormatChanged: (CalendarFormat _format) {
        setState(() {
          format = _format;
        });
      },
      rowHeight: widget.size.height * .05,

      // Day Changed
      onDaySelected: (DateTime selectDay, DateTime focusDay) {
        setState(() {
          selectedDay = selectDay;
          focusedDay = focusDay;
          offsetShadow = selectedDay.day == DateTime.now().day ? 0 : -2;
        });
      },
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },

      // Calender Style
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        selectedDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedDay.day == DateTime.now().day
                ? const Color(0XFFFF8383)
                : Colors.transparent),
        selectedTextStyle: TextStyle(
            color: selectedDay.day == DateTime.now().day
                ? Colors.white
                : Colors.transparent,
            shadows: [Shadow(offset: Offset(0, offsetShadow))],
            textBaseline: TextBaseline.ideographic,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.solid,
            decorationThickness: 3,
            decorationColor: const Color(0XFF34C759)),
        todayDecoration: const BoxDecoration(
            color: Color(0XFFFF8383), shape: BoxShape.circle),
      ),

      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle:
            TextStyle(fontFamily: 'RobotoRegular', fontWeight: FontWeight.w700),
        weekendStyle:
            TextStyle(fontFamily: 'RobotoRegular', fontWeight: FontWeight.w700),
      ),
      // Calender Builders
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          if (day.weekday == DateTime.sunday) {
            final text = DateFormat.E('id_ID').format(day);

            return Center(
              child: Text(
                text,
                style: const TextStyle(
                    fontFamily: 'RobotoRegular',
                    fontWeight: FontWeight.w700,
                    color: Colors.red),
              ),
            );
          }
        },
      ),
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
