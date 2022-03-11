import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoliciesCompanyscreen extends StatefulWidget {
  const PoliciesCompanyscreen({Key key}) : super(key: key);

  @override
  _PoliciesCompanyscreenState createState() => _PoliciesCompanyscreenState();
}

class _PoliciesCompanyscreenState extends State<PoliciesCompanyscreen> {
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
