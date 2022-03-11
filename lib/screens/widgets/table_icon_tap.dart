import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableIconTap extends StatelessWidget {
  TableIconTap({Key key,@required this.onTap,this.height,this.width, @required this.color,@required this.icon}) : super(key: key);

  Function onTap;
  double height;
  double width;
  Color color;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTap,
      child: Container(
        height: height ?? 25.h,
        width: width ?? 25.h,
        decoration:  BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child:  Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

