import 'package:archerhr_mobile/screens/widgets/circular_progress_indicator.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  const Button(
      {Key key,
      this.child,
      @required this.label,
      this.isInAsync = false,
      @required this.onPressed,
      this.padding,
      this.margin,
      this.circularProgressIndicatorColor,
      this.borderRadius,
      this.labelStyle,
      this.height,
      this.width,
      this.isDense = false,
      this.circularProgressIndicatorSize})
      : super(key: key);

  final Widget child;
  final String label;
  final bool isInAsync;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color circularProgressIndicatorColor;
  final double borderRadius;
  final TextStyle labelStyle;
  final double height;
  final double width;
  final bool isDense;
  final Size circularProgressIndicatorSize;

  @override
  Widget build(BuildContext context) {
    Widget _child = child;

    if (isInAsync) {
      _child = AppProgressIndicator(
        size: 20.0.r,
        color: Colors.white,
      );
    } else {
      _child = Text(
        "$label",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 14.0.sp,
        ).merge(labelStyle),
      );
    }

    return Container(
      //width: isDense ? null : (width ?? 1.0.sw),
      height: isDense ? null : (height ?? 40.0.h),
      margin: margin ?? EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.r),
        color: Palette.buttonBackgroundColor,
      ),
      child: TextButton(
        onPressed: !isInAsync ? onPressed : null,
        child: _child,
      ),
    );

  }
}
