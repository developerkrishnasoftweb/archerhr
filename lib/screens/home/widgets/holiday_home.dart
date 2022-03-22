import 'dart:ui';

import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/home_details_provider.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HolidayHomeScreen extends StatefulWidget {
  const HolidayHomeScreen({Key key}) : super(key: key);

  @override
  _HolidayHomeScreenState createState() => _HolidayHomeScreenState();
}

class _HolidayHomeScreenState extends State<HolidayHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SizedBox(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.home,
                    size: 15,
                  ),
                  sizeBox5w,
                  Text(
                    "Upcoming Holidays",
                    style: TextStyle(
                      fontSize: 10.h,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Consumer<HomeEmployeeDataProvider>(builder: (context, provider, child) {
                if (provider.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Palette.circularProgress,
                    ),
                  );
                }
                if (provider.holidays.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10.h, right: 10.w),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.holidays.length,
                        itemBuilder: (context, index) {
                          DateTime date = DateFormat('dd-MMM-yy').parse(provider.holidays[index].holidayDate);
                          final int day = date.day % 10;
                          String suffix = "th";
                          if ((day > 0 && day < 4) && (date.day < 11 || date.day > 13)) {
                            suffix = <String>['st', 'nd', 'rd'][day - 1];
                          }
                          String showDate = DateFormat("d").format(date);
                          String showMonth = DateFormat(" MMMM").format(date);
                          return Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.wb_sunny_outlined, color: Colors.cyan, size: 30),
                                  sizeBox10w,
                                  Text(
                                    showDate,
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                  Transform.translate(
                                    offset: const Offset(0.0, -6.0),
                                    child: Text(
                                      suffix,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    showMonth +", "+ provider.holidays[index].holiday,
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              sizeBox5h,
                            ],
                          );
                        }),
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
    );
  }
}
