import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

Future<void> deleteCacheDir() async {
  final cacheDir = await getTemporaryDirectory();

  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }
}

Future<void> deleteAppDir() async {
  final appDir = await getApplicationDocumentsDirectory();

  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
}

Future<void> deleteAppSupportDir() async {
  final appDir = await getApplicationSupportDirectory();

  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
}

Widget buildDoubleButtonPopupDialog(
    {BuildContext context, IconData icon, Color colorIcon ,String mainText, String text, String buttonName, Function onPressed,Color colorButton}) {
  return AlertDialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
    titlePadding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.r),
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Icon(
            icon,
            color: colorIcon ?? Colors.red,
            size: 100.sp,
          ),
        ),
        sizeBox10h,
        Center(
          child: Text(
            mainText,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 28.sp,
            ),
          ),
        ),
        sizeBox10h,
        Center(
          child: Text(
            text,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
        sizeBox20h,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.r), color: colorButton ?? Colors.red),
              child: TextButton(
                onPressed: onPressed,
                child: Text(
                  buttonName ?? "YES,DELETE IT!",
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
              ),
            ),
            Card(
              elevation: 1,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.r), color: Colors.white),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "NO,CANCEL!",
                    style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget buildSingleButtonPopupDialog(
    {BuildContext context, IconData icon, String mainText, String text, Function onPressed, Color iconColor}) {
  return AlertDialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
    titlePadding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.r),
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Icon(
            icon,
            color: iconColor ?? Colors.green,
            size: 100.sp,
          ),
        ),
        sizeBox10h,
        Center(
          child: Text(
            mainText,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 28.sp,
            ),
          ),
        ),
        sizeBox10h,
        Center(
          child: Text(
            text,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
        sizeBox20h,
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.r),
              color: Palette.buttonBackgroundColor,
            ),
            child: TextButton(
              onPressed: onPressed,
              child: Text(
                "OK",
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

unAuthenticationDialog(BuildContext context){
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return buildSingleButtonPopupDialog(
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.red,
            mainText: "Session Out",
            text: "Please login again.",
            onPressed: () async {
              kSharedPreferences.clear();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
              );
              await FlutterRestart.restartApp();
              //await Phoenix.rebirth(context);
            });
      });
}

appliedStatus() {
  return const Center(
    child: Icon(
        Icons.touch_app_rounded, color: Colors.cyan),
  );
}

approveStatus() {
  return const Center(
    child: Icon(
        Icons.thumb_up_alt_rounded, color: Colors.green),
  );
}

rejectStatus(){
  return const Center(
    child: Icon(
        Icons.thumb_down_alt_rounded, color: Colors.red),
  );
}

saveStatus(){
  return const Center(
    child: Icon(
        Icons.save_rounded, color: Colors.orange),
  );
}