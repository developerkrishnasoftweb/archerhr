import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleText extends StatelessWidget {
  const TitleText({Key key,@required this.label,this.alignment}) : super(key: key);

  final String label;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
      alignment: alignment ?? Alignment.topLeft,
    );
  }
}
