// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:employee_management/pages/home/components/carousel_hightlight.dart';
import 'package:employee_management/pages/home/components/noted_data.dart';
import 'package:flutter/material.dart';
import 'package:employee_management/global_components/company_calender.dart';
import 'package:employee_management/pages/home/components/card_attendance_time.dart';
import 'package:employee_management/pages/home/components/menu_icon_home.dart';
import 'package:employee_management/pages/home/components/note_text_field.dart';
import 'package:employee_management/pages/home/components/user_information.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key})
      : super(key: key);
  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int activeIndexCarousel = 0;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  double offsetShadow = 0;
  bool isDaySelected = false;

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

  List<Widget> notedData = <Widget>[
    NotedData(
      notedValue:
          'Jam 14:00asdfasdfasdfasdfsdafasdfsdafsdafasdfasdfsadfdsafsadfds',
    ),
    NotedData(
      notedValue: 'Jam 14:00. Maen Valorant',
    ),
  ];

  List images = [
    'https://wallpaperaccess.com/full/14358.jpg',
    'https://wallpapers-hub.art/wallpaper-images/54669.jpg',
    'https://wallpaperforu.com/wp-content/uploads/2020/04/10127071920x1200.jpg'
  ];

  CarouselController controllerDot = CarouselController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: themePrimayColor,
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            // TOP CONTENT
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
                        dateFormat: dateFormat,
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
            // SIZE BOX FOR SPACER
            SizedBox(
              height: size.height * 0.015,
            ),
            // CALENDER
            Container(
              color: kPrimaryColor,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10, left: size.width * .04, right: 5),
                    child: const Text(
                      'Pengingat',
                      style: TextStyle(
                          fontFamily: 'RobotoRegular',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2, left: 7, right: 5),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.all(8.0),
                        child: CompanyCalender(
                          focusedDay: focusedDay,
                          selectedDay: selectedDay,
                          format: format,
                          offsetShadow: offsetShadow,
                          onSelectedDay:
                              (DateTime selectDay, DateTime focusDay) {
                            setState(() {
                              selectedDay = selectDay;
                              focusedDay = focusDay;
                              isDaySelected = true;
                              offsetShadow =
                                  selectedDay.day == DateTime.now().day
                                      ? 0
                                      : -2;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2, left: 7, right: 5),
                      child: isDaySelected
                          ? Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        offset: Offset(0, 2),
                                        blurRadius: 2,
                                        spreadRadius: 0)
                                  ]),
                              margin: const EdgeInsets.all(8.0),
                              child: const NoteTextField())
                          : null,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 2, left: 7, right: 5, bottom: size.height * .03),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: size.width * .025, right: 5),
                              child: const Text('Noted',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'RobotoMedium',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          Container(
                              height: size.height * 0.1,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        offset: Offset(0, 2),
                                        blurRadius: 2,
                                        spreadRadius: 0)
                                  ]),
                              margin: const EdgeInsets.all(8.0),
                              child: Scrollbar(
                                hoverThickness: 2,
                                isAlwaysShown: true,
                                interactive: true,
                                controller: _scrollController,
                                thickness: 5,
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: notedData.length,
                                  itemBuilder: (context, index) {
                                    double margin = 0;
                                    if (notedData.length > 1 &&
                                        index != notedData.length - 1) {
                                      margin = size.width * 0.01;
                                    }
                                    return ClipPath(
                                      clipper: const ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                                style: BorderStyle.solid,
                                                width: 6,
                                                color: Colors.green),
                                          ),
                                          // borderRadius: BorderRadius.circular(10),
                                        ),
                                        margin: EdgeInsets.only(bottom: margin),
                                        child: notedData[index],
                                      ),
                                    );
                                  },
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            // HIGHT LIGHT
            SizedBox(
              height: size.height * 0.015,
            ),
            Container(
              color: kPrimaryColor,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: size.width * .04,
                        right: 5,
                        bottom: size.height * 0.02),
                    child: const Text(
                      'Highlight',
                      style: TextStyle(
                          fontFamily: 'RobotoRegular',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  CarouselHighlight(
                    controller: controllerDot,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndexCarousel = index;
                      });
                    },
                    onDotClicked: (index) {
                      controllerDot.animateToPage(
                        index,
                        duration: Duration(seconds: 1),
                        curve: Curves.ease
                      );
                    },
                    activeIndexImages: activeIndexCarousel,
                    images: images,
                    size: size,
                  )
                ],
              ),
            ),
          ],
        ));
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
