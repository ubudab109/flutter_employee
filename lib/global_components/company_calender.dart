import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CompanyCalender extends StatelessWidget {
  const CompanyCalender(
      {Key? key,
      required this.format,
      required this.selectedDay,
      required this.focusedDay, 
      this.onSelectedDay, 
      required this.offsetShadow})
      : super(key: key);
  final CalendarFormat format;
  final DateTime selectedDay;
  final DateTime focusedDay;
  
  final double offsetShadow;

  final void Function(DateTime selectedDay, DateTime focusedDay)? onSelectedDay;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return TableCalendar(
      locale: 'id_ID',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      // eventLoader: ,
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

      // Day Changed
      onDaySelected: onSelectedDay,
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
