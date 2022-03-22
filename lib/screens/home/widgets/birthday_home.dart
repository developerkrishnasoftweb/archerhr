import 'package:archerhr_mobile/const/const_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BirthDayHomeScreen extends StatefulWidget {
  const BirthDayHomeScreen({Key key}) : super(key: key);

  @override
  _BirthDayHomeScreenState createState() => _BirthDayHomeScreenState();
}

class _BirthDayHomeScreenState extends State<BirthDayHomeScreen> {
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
          padding: EdgeInsets.only(left: 10.w, top: 10.h,bottom: 10.h),
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
                    "Birthday Wishes",
                    style: TextStyle(
                      fontSize: 10.h,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, right: 10.w),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 35.w,
                                height: 35.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(237, 237, 237, 1),
                                ),
                              ),
                              sizeBox10w,
                              Expanded(
                                child: Container(
                                  width: size.width,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(237, 237, 237, 1),
                                      borderRadius: BorderRadius.circular(10.r)),
                                ),
                              )
                            ],
                          ),
                          sizeBox5h,
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
