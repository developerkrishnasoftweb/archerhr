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
      padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 5.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CalendarHomeScreen(),
            //const TaskHomeScreen(),
            //const NewsHomeScreen(),
            /*Row(
              children: const [
                MyLeaveHomeScreen(),
                //sizeBox10w,
                MyAttendanceHomeScreen(),
              ],
            ),*/
            const MyClaimHomeScreen(),
            const MyTravelHomeScreen(),
            const BirthDayHomeScreen(),
            const HolidayHomeScreen(),
            sizeBox10h
          ],
        ),
      ),
    );
  }
}
