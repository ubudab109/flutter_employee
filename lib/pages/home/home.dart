// ignore_for_file: prefer_const_constructors
import 'dart:collection';
import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:employee_management/apps/model/employee_note/employee_note.dart';
import 'package:employee_management/apps/provider/user/user_provider.dart';
import 'package:employee_management/apps/repository/auth_repository.dart';
import 'package:employee_management/apps/repository/note_data_repository.dart';
import 'package:employee_management/pages/detail_notes/detail_notes.dart';
import 'package:employee_management/pages/home/components/carousel_hightlight.dart';
import 'package:employee_management/pages/home/components/circle_button_note.dart';
import 'package:employee_management/pages/home/components/note_data_empty.dart';
import 'package:employee_management/pages/home/components/noted_data.dart';
import 'package:employee_management/pages/home/components/selected_time_note.dart';
import 'package:employee_management/pages/home/components/shimmer_calender.dart';
import 'package:flutter/material.dart';
import 'package:employee_management/pages/home/components/card_attendance_time.dart';
import 'package:employee_management/pages/home/components/menu_icon_home.dart';
import 'package:employee_management/pages/home/components/note_button.dart';
import 'package:employee_management/pages/home/components/user_information.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);
  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {

  // initialize future note data
  late Future<List<EmployeeNote>> noteDataFuture;

  // provider user (To Get User Auth Data)
  UserProvider? userProvider;

  // carousel initial index
  int activeIndexCarousel = 0;

  // calender format
  CalendarFormat format = CalendarFormat.month;

  // offshet shadow for selected day (default 0)
  double offsetShadow = 0;

  // conidition to get is day selected or not
  bool isDaySelected = false;

  // condition for selected time in create notes
  bool isTimeSelected = false;

  // token user
  late String tokenUser;

  // FOR CALENDER
  CalendarFormat calendarFormat = CalendarFormat.month;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date
  DateTime focusedDay = DateTime.now();
  DateTime kFirstDay = DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  DateTime kLastDay = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);
  DateTime? selectedDay;
  DateTime? rangeStart;
  DateTime? rangeEnd;
  late LinkedHashMap<DateTime, List<EmployeeNote>> _groupedEvents;
  late LinkedHashMap<DateTime, List<EmployeeNote>> events;
  //END

  /// SCROLLABLE CONTROLLER
  CarouselController controllerDot = CarouselController();
  final _scrollController = ScrollController();


  /// FOR MODAL SHEET NOTE CREATE
  late String dateFormat;
  late String days;
  late String modalDateNote;
  String? dateNote;

  // controller text for post note data
  TimeOfDay time = TimeOfDay.now();
  TextEditingController noteText = TextEditingController();
  String colorNote = '0x0fffffff';
  // Format date in modal sheet
  final DateFormat formatterDateNote = DateFormat("EEEE, yyyy-MM-dd", "id_ID");
  final DateFormat formatterModalNote = DateFormat("EEEE, d MMMM yyyy", "id_ID");
  


  

  /// for get hash code in date time
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  /// get grouping notes or event in a day
  List<EmployeeNote> _getEventsForDay(DateTime date) {
    return _groupedEvents[date] ?? [];
  }

  /// grouping process for notes or event in a day
  _groupEvents(List<EmployeeNote> notes) {
    _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    for (var event in notes) {
      DateTime date =
          DateTime.utc(event.date.year, event.date.month, event.date.day, 12);
      if (_groupedEvents[date] == null) _groupedEvents[date] = [];
      _groupedEvents[date]?.add(event);
    }
  }

  List images = [
    'https://wallpaperaccess.com/full/14358.jpg',
    'https://wallpapers-hub.art/wallpaper-images/54669.jpg',
    'https://wallpaperforu.com/wp-content/uploads/2020/04/10127071920x1200.jpg'
  ];
  
  /// get data note or events employee 
  /// 
  /// then cast to employee note model
  Future<List<EmployeeNote>> getNoteEmployee() async {
    var token = await AuthRepository().hasToken();
    http.Response response = await NoteDataRepository().getNoteDate(token);
    var map = json.decode(response.body)['data'];
    List<EmployeeNote> employeeNotes = [];

    if (map != null) {
      for (var value in map) {
        EmployeeNote employeeNote = EmployeeNote(
          id: value['id'].toString(),
          color: value['color'] ?? '0XFFFFFFF',
          date: DateTime.parse(value['date']),
          note: value['note'],
          time: value['time'],
        );
        employeeNotes.add(employeeNote);
      }
    }

    // print(employeeNotes);
    return employeeNotes;
  }

  Future<EmployeeNote> createNoteEmployee() async {
    var token = await AuthRepository().hasToken();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay!);
    var hourTime = time.hour < 10 ? '0${time.hour.toString()}' : time.hour.toString();
    var minuteTime = time.minute < 10 ? '0${time.minute.toString()}' : time.minute.toString();
    http.Response response = await NoteDataRepository().postNoteData(token, formattedDate, '$hourTime:$minuteTime', noteText.text, colorNote);
    return EmployeeNote.fromJson(jsonDecode(response.body)['data']);
  }
  
  @override
  void initState()  {
    super.initState();
    initializeDateFormatting();
    noteDataFuture = getNoteEmployee();
    selectedDay = focusedDay;
    DateTime now = DateTime.now();
    dateFormat = DateFormat('dd/MM/yyyy', 'id_ID').format(now).toString();
    days = DateFormat('EEEE', 'id_ID').format(now);
    modalDateNote = formatterModalNote.format(now).toString();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>  UserProvider(),),
      ],
      builder: (newContext, child) {
        final userProvider = Provider.of<UserProvider>(newContext, listen: false);
        newContext.read<UserProvider>().getUserData;
        return RefreshIndicator(
          onRefresh: () async {
            await userProvider.getUserData;
            setState(() {
              noteDataFuture = getNoteEmployee();
            });
          },
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: themePrimayColor,
              body: Consumer<UserProvider>(
                builder: (context, value, child) {
                  return value.userData.isEmpty && !value.error
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : value.error
                          ? ScaffoldMessenger(child: Text(value.errorMessage))
                          : ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: <Widget>[
                                // TOP CONTENT
                                Container(
                                  color: kPrimaryColor,
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
                                              padding: EdgeInsets.only(
                                                  bottom: size.height * 0.05),
                                              child: UserInformationWidget(
                                                size: size,
                                                fullname: value.userData['data']['fullname'],
                                                role: value.userData['data']['role'].toUpperCase(),
                                                nip: value.userData['data']['nip'],
                                              ),
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
                                        width: double.infinity,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.33
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
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
                                                    icon: 'data_rekening.png',
                                                    iconName: 'Data Rekening',
                                                  ),        
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(22.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: const <Widget>[
                                                    MenuIconHome(
                                                      onPressed: null,
                                                      icon: 'peringatan.png',
                                                      iconName: 'Peringatan',
                                                    ),
                                                    
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
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
                                _calenderMain(context, size, setState),
                                // HIGHT LIGHT
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                Container(
                                  color: kPrimaryColor,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          controllerDot.animateToPage(index,
                                              duration: Duration(seconds: 1),
                                              curve: Curves.ease);
                                        },
                                        activeIndexImages: activeIndexCarousel,
                                        images: images,
                                        size: size,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                },
              )),
        );
      },
    );
  }

  /* Bottom Sheed Modal */
  Widget _modalBottomSheet(BuildContext context, String date, Size size, StateSetter setStateModal) {

    /* ON PRESSED COLOR NOTE SELECT */
    onPressedColorModal(String value) {
      setStateModal(() {
        colorNote = value;
      });
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP HEADER MODAL BUTTON
            GestureDetector(
              onTap: () {
                setState(() {
                  time = TimeOfDay.now();
                  isTimeSelected = false;
                  colorNote = '0x0fffffff';
                });
                noteText.clear();
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Image.asset('assets/images/top_modal.png'),
                ),
              ),
            ),

            // DATE SELECTED
            Padding(
              padding: EdgeInsets.only(top: 32, left: 20),
              child: Text(
                date,
                style: const TextStyle(
                    fontFamily: 'RobotoMedium',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            
            // TIME PICKER
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    child: SizedBox(
                      width: size.width * 0.3,
                      height: size.height * 0.06,
                      child: Image.asset('assets/images/clock.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: time,
                        builder: (context, child) => MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: true),
                            child: child!),
                      );
                      if (picked != null && picked != time) {
                        setStateModal(() {
                          time = picked;
                          isTimeSelected = true;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      child: SizedBox(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: isTimeSelected
                              ? SelectedTime(
                                  hour: time.hour < 10
                                      ? '0${time.hour.toString()}'
                                      : time.hour.toString(),
                                  minute: time.minute < 10
                                      ? '0${time.minute.toString()}'
                                      : time.minute.toString(),
                                )
                              : SelectedTime(hour: '00', minute: '00'),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            // TEXT FIELD INPUT
            Padding(
                padding: EdgeInsets.only(top: 32, left: 20),
                child: Container(
                  width: size.width * 0.87,
                  decoration: BoxDecoration(
                    color: Colors.white,
                      border: Border(
                        left: BorderSide(
                            style: BorderStyle.solid,
                            width: 4,
                            color: Color(int.parse(colorNote))
                        ),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: Offset(0, 10),
                            blurRadius: 5.0,
                            spreadRadius: 0)
                      ]),
                  child: TextField(
                    controller: noteText,
                    autofocus: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    ),
                    
                    maxLength: 100,
                    maxLines: null,
                    buildCounter: (_, {required currentLength, maxLength, required isFocused}) =>
                        Text(
                              currentLength.toString() + "/" + maxLength.toString(),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'RobotoMedium',
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                          ),
                    ),
                  ),
                )),

            // COLOR NOTE PICKER
            Padding(
              padding: EdgeInsets.only(top: 32, left: 20),
              child: Container(
                width: size.width * 0.87,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          offset: Offset(0, 10),
                          blurRadius: 5.0,
                          spreadRadius: 0)
                    ]),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        // COLOR WHITE
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.01,
                              bottom: size.height * 0.01,
                              left: size.width * 0.04),
                          child: CircleButton(
                            onPressed: () => onPressedColorModal('0x0fffffff'),
                            color: Colors.white,
                            icon: Image.asset('assets/images/forbidden.png'),
                          ),
                        ),

                        // COLOR BLUE
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.01,
                              bottom: size.height * 0.01,
                              left: size.width * 0.04),
                          child: CircleButton(
                            onPressed: () => onPressedColorModal('0XFF34C7C7'),
                            color: Color(0XFF34C7C7),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.01,
                              bottom: size.height * 0.01,
                              left: size.width * 0.04),
                          child: CircleButton(
                            onPressed: () => onPressedColorModal('0XFFFFB800'),
                            color: Color(0XFFFFB800),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.01,
                              bottom: size.height * 0.01,
                              left: size.width * 0.04),
                          child: CircleButton(
                            onPressed: () => onPressedColorModal('0XFF0015CD'),
                            color: Color(0XFF0015CD),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.01,
                              bottom: size.height * 0.01,
                              left: size.width * 0.04),
                          child: CircleButton(
                            onPressed: () => onPressedColorModal('0XFFFF0000'),
                            color: Color(0XFFFF0000),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.01,
                              bottom: size.height * 0.01,
                              left: size.width * 0.04),
                          child: CircleButton(
                            onPressed: () => onPressedColorModal('0XFFC75734'),
                            color: Color(0XFFC75734),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            
            // SAVE
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 20, right: size.width * 0.07),
                    child: SizedBox(
                      width: 100,
                      height: 33,
                      child: ElevatedButton(
                        onPressed: () async {
                          await createNoteEmployee();
                          Navigator.pop(context);
                          setState(() {
                            time = TimeOfDay.now();
                            isTimeSelected = false;
                            colorNote = '0x0fffffff';
                            noteDataFuture = getNoteEmployee();
                          });
                        } ,
                        child: Text(
                          'Simpan', 
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'RobotoMedium',
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                          
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              kBluePrimary),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            
            SizedBox(
              height: size.height * 0.01,
            )
          ],
        ),
      ),
    );
  }

  /* CALENDER MAIN */
  Widget _calenderMain(BuildContext context, Size size, StateSetter setStateCalender) {

    /* SHOW MODAL BOTTOM SHEET */
    void onPressedNote(String date) {
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Color(0XFFF2F2F2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) =>  _modalBottomSheet(context, date, size, setState),
          );
        },
      ).whenComplete(() {
        setState(() {
          time = TimeOfDay.now();
          isTimeSelected = false;
          colorNote = '0x0fffffff';
        });
        noteText.clear();
      });
    }

    /// event change for selected day in calender
    void _onDaySelected(DateTime selectedDays, DateTime focusedDays) {
      if (!isSameDay(selectedDay, selectedDays)) {
        setState(() {
          selectedDay = selectedDays;
          focusedDay = focusedDays;
          rangeStart = null; // Important to clean those
          rangeEnd = null;
          rangeSelectionMode = RangeSelectionMode.toggledOff;
          isDaySelected = true;
          dateNote = formatterDateNote.format(selectedDays).toString();
          modalDateNote = formatterModalNote.format(selectedDays).toString();
          offsetShadow = selectedDay?.day == DateTime.now().day ? 0 : -2;
        });
        _getEventsForDay(selectedDays);
      }
    }


    /// On range selected
    void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDays) {
      setState(() {
        selectedDay = null;
        focusedDay = focusedDay;
        rangeStart = start;
        rangeEnd = end;
        rangeSelectionMode = RangeSelectionMode.toggledOn;
      });

      // `start` or `end` could be null
      
      if (start != null) {
        _getEventsForDay(start);
      } else if (end != null) {
        _getEventsForDay(end);
      }
    }

    return FutureBuilder(
      future: noteDataFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final events = snapshot.data;
            _groupEvents(events);
            DateTime? selectedDate = selectedDay;
            final _selectedEvents  = _groupedEvents[selectedDate] ?? [];
            return Container(
              color: kPrimaryColor,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: size.width * .04,
                        right: 5),
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
                        child: 
                        /** CALENDER */
                        TableCalendar<EmployeeNote>(
                            locale: 'id_ID',
                            firstDay: kFirstDay,
                            lastDay: kLastDay,
                            focusedDay: focusedDay,
                            onPageChanged: (focusedDays) {
                              focusedDay = focusedDays;
                            },
                            eventLoader: _getEventsForDay,
                            startingDayOfWeek: StartingDayOfWeek.sunday,
                            daysOfWeekVisible: true,
                            headerStyle: const HeaderStyle(
                                decoration: BoxDecoration(
                                  color: Color(0XFFFF6161),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                ),
                                formatButtonVisible: false,
                                titleCentered: true,
                                formatButtonShowsNext: true,
                                titleTextStyle: TextStyle(
                                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                                headerMargin: EdgeInsets.only(bottom: 10)),
                            calendarFormat: format, 
                            onFormatChanged: null,
                            rowHeight: size.height * .05,
                            rangeSelectionMode: rangeSelectionMode,
                            // Day Changed
                            onDaySelected: _onDaySelected,
                            selectedDayPredicate: (day) {
                              return isSameDay(day, selectedDay);
                            },
                            onRangeSelected: _onRangeSelected,
                            // Calender Style
                            calendarStyle: CalendarStyle(
                              isTodayHighlighted: true,
                              markerDecoration: BoxDecoration(
                                color: Colors.green
                              ),
                              selectedDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectedDay?.day == DateTime.now().day
                                      ? const Color(0XFFFF8383)
                                      : Colors.transparent),
                              selectedTextStyle: TextStyle(
                                  color: selectedDay?.day == DateTime.now().day
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
                          ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2, left: 7, right: 5),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: NoteButton( onPressed: () => onPressedNote(modalDateNote))),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 2,
                          left: 7,
                          right: 5,
                          bottom: size.height * .03),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10,
                                  left: size.width * .025,
                                  right: 5),
                              child: const Text('Noted',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'RobotoMedium',
                                      fontSize: 18,
                                      fontWeight:FontWeight.w500)),
                            ),
                          ),
                          Container(
                              height: size.height * 0.06,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:BorderRadius.circular(7.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color:Color.fromRGBO(0, 0, 0,0.25),
                                        offset:Offset(0, 2),
                                        blurRadius: 2,
                                        spreadRadius: 0)
                                  ]),
                              margin:const EdgeInsets.all(8.0),
                              child: _selectedEvents.isEmpty ? 
                              ClipPath(
                                  clipper: const ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                                  child: Container(
                                      decoration:
                                      BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                              style: BorderStyle.solid,
                                              width: 6,
                                              color: Colors.white
                                          ),
                                        ),
                                        // borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only( bottom: 1 ),
                                      child: NoteDataEmpty()
                                      ),
                                  ) : 
                              Scrollbar(
                                hoverThickness: 2,
                                isAlwaysShown: true,
                                interactive: true,
                                controller:_scrollController,
                                thickness: 5,
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: _selectedEvents.length,
                                  itemBuilder: (context, index) {
                                    EmployeeNote note = _selectedEvents[index];
                                     return ClipPath(
                                      clipper: const ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                                      child: Container(
                                          decoration:
                                          BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                  style: BorderStyle.solid,
                                                  width: 6,
                                                  color: Color(int.parse(note.color))
                                              ),
                                            ),
                                            // borderRadius: BorderRadius.circular(10),
                                          ),
                                          margin: EdgeInsets.only( bottom: 1 ),
                                          child: NotedData(
                                                notedValue: note.note
                                              )
                                          ),
                                      );

                                  },
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  _selectedEvents.isNotEmpty ? GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay!);

                        return DetailNotes(date: formattedDate.toString(), dateFormat:  formatterModalNote.format(selectedDate!).toString(),);
                      },
                    )), 
                     
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: size.width * 0.04,
                          bottom: size.height * 0.04
                        ),
                        child: Text.rich(
                          TextSpan(
                            children : [
                              TextSpan(
                                text: 'Detail',
                                style: TextStyle(
                                  color: kBluePrimary,
                                  fontFamily: 'RobotoMedium',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                              WidgetSpan(
                                child: SvgPicture.asset('assets/svg/arrow_right.svg'),
                              ),
                            ]
                          )
                        ),
                      ),
                    ),
                  ) : Text('')
                ],
              ),
            );
          } else {
            return ShimmerCalendarLoading();
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerCalendarLoading();
        } else if (snapshot.connectionState == ConnectionState.active) {
            return ShimmerCalendarLoading();
        } else {
            return ScaffoldMessenger(child: Text('Tidak Ada Koneksi Internet'));
        }
      }
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
