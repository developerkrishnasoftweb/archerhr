import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HolidaysCompanyScreen extends StatefulWidget {
  const HolidaysCompanyScreen({Key key}) : super(key: key);

  @override
  _HolidaysCompanyScreenState createState() => _HolidaysCompanyScreenState();
}

class _HolidaysCompanyScreenState extends State<HolidaysCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text(
            "COMING SOON",
            style: TextStyle(fontSize: 20.sp),
          ),
        ],
      ),
    );
  }
}
