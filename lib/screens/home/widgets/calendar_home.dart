import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarHomeScreen extends StatefulWidget {
  const CalendarHomeScreen({Key key}) : super(key: key);

  @override
  _CalendarHomeScreenState createState() => _CalendarHomeScreenState();
}

class _CalendarHomeScreenState extends State<CalendarHomeScreen> {
  CalendarFormat format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: TableCalendar(
          focusedDay: DateTime.now(),
          lastDay: DateTime.utc(2040, 10, 20),
          firstDay: DateTime.utc(1990, 10, 20),
          calendarFormat: format,
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekendStyle: TextStyle(fontWeight: FontWeight.w700),
            weekdayStyle: TextStyle(fontWeight: FontWeight.w700),
          ),
          availableGestures: AvailableGestures.horizontalSwipe,
          onFormatChanged: (CalendarFormat _format) {
            setState(() {
              format = _format;
            });
          },
          headerStyle: HeaderStyle(
            formatButtonVisible: true,
            titleCentered: false,
            formatButtonShowsNext: false,
            formatButtonDecoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(5.r),
            ),
            formatButtonTextStyle: const TextStyle(color: Colors.white),
          ),
          calendarStyle: CalendarStyle(
            defaultTextStyle: const TextStyle(fontWeight: FontWeight.w500),
            isTodayHighlighted: true,
            selectedTextStyle: const TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
              color: Colors.cyan,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ),
    );
  }
}
