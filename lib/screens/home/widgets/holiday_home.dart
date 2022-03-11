import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/home_details_provider.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.holidays.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.wb_sunny_outlined, color: Colors.cyan, size: 30),
                                  sizeBox10w,
                                  Text(
                                    provider.holidays[index].holidayDate + " " + provider.holidays[index].holiday,
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
