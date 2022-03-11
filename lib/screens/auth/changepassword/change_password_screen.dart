import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      titlePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(
                "Change Password",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          child: Text(
                            "Old Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        TextFormField(
                          controller: oldPasswordController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              sizeBox20h,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          child: Text(
                            "New Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        TextFormField(
                          controller: newPasswordController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              sizeBox20h,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          child: Text(
                            "Confirm Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              sizeBox30h,
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.r),
                    color: Palette.buttonBackgroundColor,
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (oldPasswordController.text.isNotEmpty &&
                          newPasswordController.text.isNotEmpty &&
                          confirmPasswordController.text.isNotEmpty) {
                        Navigator.pop(context);
                      } else {
                        if (oldPasswordController.text.isEmpty) {
                          Utils.showToast("Please enter old name");
                        } else if (newPasswordController.text.isEmpty) {
                          Utils.showToast("Please enter new name");
                        } else {
                          Utils.showToast("Please enter confirm name");
                        }
                      }
                    },
                    child: const Text(
                      'UPDATE PASSWORD',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
