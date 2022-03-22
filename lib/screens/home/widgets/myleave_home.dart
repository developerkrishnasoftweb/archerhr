import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/dashboard_provider.dart';
import 'package:archerhr_mobile/screens/dashboard/view/dashboard_screen.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class MyLeaveHomeScreen extends StatefulWidget {
  const MyLeaveHomeScreen({Key key}) : super(key: key);

  @override
  _MyLeaveHomeScreenState createState() => _MyLeaveHomeScreenState();
}

class _MyLeaveHomeScreenState extends State<MyLeaveHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(
                selectedPage: 1,
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            height: 180.h,
            width: 180.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.home,
                        size: 15,
                      ),
                      sizeBox5w,
                      Text(
                        "My Leaves",
                        style: TextStyle(
                          fontSize: 10.h,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                sizeBox30h,
                Consumer<DashboardProvider>(builder: (context, provider, child) {
                  if (provider.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Palette.circularProgress,
                      ),
                    );
                  }
                  if (provider.leaveAvailability.isNotEmpty) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Casual Leaves ${provider.leaveAvailability[0].leaveConsumed.toString().split(".0").first}/${int.parse(provider.leaveAvailability[0].leaveTotal.toString().split(".").first)}",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                          child: LinearPercentIndicator(
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: 8.h,
                            percent: provider.leaveAvailability[0].leaveConsumed / provider.leaveAvailability[0].leaveTotal,
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.blue[400],
                            backgroundColor: Colors.grey[300],
                            /*progressColor: Colors.blue[300],
                              backgroundColor: Colors.blue[400],*/
                              //animateFromLastPercent: true,
                              //isRTL: true,
                          ),
                        ),
                        sizeBox10h,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Sick Leaves ${provider.leaveAvailability[1].leaveConsumed.toString().split(".0").first}/${int.parse(provider.leaveAvailability[1].leaveTotal.toString().split(".").first)}",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                          child: LinearPercentIndicator(
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: 8.h,
                            percent: provider.leaveAvailability[1].leaveConsumed / provider.leaveAvailability[1].leaveTotal,
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.orange[400],
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text(
                      "No Data Found",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
