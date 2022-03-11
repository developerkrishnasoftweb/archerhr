import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnnouncementCompanyScreen extends StatefulWidget {
  const AnnouncementCompanyScreen({Key key}) : super(key: key);

  @override
  _AnnouncementCompanyScreenState createState() => _AnnouncementCompanyScreenState();
}

class _AnnouncementCompanyScreenState extends State<AnnouncementCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "COMING SOON",
            style: TextStyle(fontSize: 20.sp),
          ),
        ],
      ),
    );
  }
}


