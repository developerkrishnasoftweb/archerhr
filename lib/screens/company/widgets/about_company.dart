import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutCompanyScreen extends StatefulWidget {
  const AboutCompanyScreen({Key key}) : super(key: key);

  @override
  _AboutCompanyScreenState createState() => _AboutCompanyScreenState();
}

class _AboutCompanyScreenState extends State<AboutCompanyScreen> {
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
