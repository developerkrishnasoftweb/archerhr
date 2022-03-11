import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/dashboard_provider.dart';
import 'package:archerhr_mobile/provider/home_details_provider.dart';
import 'package:archerhr_mobile/screens/home/widgets/attendance_home.dart';
import 'package:archerhr_mobile/screens/home/widgets/birthday_home.dart';
import 'package:archerhr_mobile/screens/home/widgets/calendar_home.dart';
import 'package:archerhr_mobile/screens/home/widgets/claim_home.dart';
import 'package:archerhr_mobile/screens/home/widgets/holiday_home.dart';
import 'package:archerhr_mobile/screens/home/widgets/myleave_home.dart';
import 'package:archerhr_mobile/screens/home/widgets/news_home.dart';
import 'package:archerhr_mobile/screens/home/widgets/task_home.dart';
import 'package:archerhr_mobile/screens/home/widgets/travel_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DashboardProvider dashboardProvider;
  HomeEmployeeDataProvider homeEmployeeDataProvider;
  CalendarFormat format = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    dashboardProvider.clear();
    dashboardProvider.getDashboardGraphData(context);

    homeEmployeeDataProvider = Provider.of<HomeEmployeeDataProvider>(context, listen: false);
    homeEmployeeDataProvider.clear();
    homeEmployeeDataProvider.getHomeDashboardEmployeeData(context);
  }

  @override
  void dispose() {
    super.dispose();
    dashboardProvider.clear();
    homeEmployeeDataProvider.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w, left: 10.w, top: 10.h),
      child: ListView(
        children: [
          const CalendarHomeScreen(),
          SizedBox(height: 7.h),
          Row(
            children: [
              const MyLeaveHomeScreen(),
              sizeBox10w,
              const MyAttendanceHomeScreen(),
            ],
          ),
          SizedBox(height: 7.h),
          const MyClaimHomeScreen(),
          SizedBox(height: 7.h),
          const MyTravelHomeScreen(),
          SizedBox(height: 4.h),
          const BirthDayHomeScreen(),
          SizedBox(height: 2.h),
          const HolidayHomeScreen(),
          SizedBox(height: 2.h),
          const TaskHomeScreen(),
          SizedBox(height: 2.h),
          const NewsHomeScreen(),
          sizeBox10h
        ],
      ),
    );
  }
}
