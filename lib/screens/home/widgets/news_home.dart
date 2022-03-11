import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/home_details_provider.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({Key key}) : super(key: key);

  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
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
                    "News & Announcement",
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
                if (provider.newsList.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10.h, right: 10.w),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.newsList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                width: size.width,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(237, 237, 237, 1),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 40.w,
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                              shape: BoxShape.rectangle,
                                              color: Colors.white,
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                  "assets/images/baby.jpeg",
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          sizeBox10w,
                                          Text(
                                            provider.newsList[index].title,
                                            style: TextStyle(
                                                fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10.0.w),
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
