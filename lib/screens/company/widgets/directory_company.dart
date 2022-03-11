import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DirectoryCompanyScreen extends StatefulWidget {
  const DirectoryCompanyScreen({Key key}) : super(key: key);

  @override
  _DirectoryCompanyScreenState createState() => _DirectoryCompanyScreenState();
}

class _DirectoryCompanyScreenState extends State<DirectoryCompanyScreen> {
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
