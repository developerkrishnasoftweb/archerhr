import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetDialog extends StatelessWidget {
  const NoInternetDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // shadowColor: Colors.transparent,
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 0.8.sw,
          padding: EdgeInsets.symmetric(vertical: 10.0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/globeOffline.png',
                height: 0.2.sh,
                width: 0.4.sw,
              ),
              sizeBox10h,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.08.sw),
                child: Text(
                  "No Internet Connection",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0.sp,
                  ),
                ),
              ),
              sizeBox20h,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.08.sw),
                child: Text(
                  "Make sure Wi-Fi or mobile data is turned on, then try again",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0.sp,
                  ),
                ),
              ),
              sizeBox30h,
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.r),
                    color: Palette.buttonBackgroundColor,
                  ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child:Text(
                      'Try Again',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    )
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
