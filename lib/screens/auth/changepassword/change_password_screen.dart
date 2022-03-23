import 'dart:developer';

import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
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
  bool isLoading = false;
  bool showOldPasswordUser = false;
  bool showConfirmPasswordUser = false;
  bool showNewPasswordUser = false;
  final _formKey = GlobalKey<FormState>();

  void toggleOldPasswordVisibility() {
    setState(() {
      showOldPasswordUser = !showOldPasswordUser;
    });
  }

  void toggleNewPasswordVisibility() {
    setState(() {
      showNewPasswordUser = !showNewPasswordUser;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      showConfirmPasswordUser = !showConfirmPasswordUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
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
        child: SingleChildScrollView(
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
                            obscureText: !showOldPasswordUser,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  toggleOldPasswordVisibility();
                                },
                                child: Icon(
                                  showOldPasswordUser ? Icons.visibility : Icons.visibility_off,
                                  color: Palette.appBarColor,
                                ),
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
                            obscureText: !showNewPasswordUser,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  toggleNewPasswordVisibility();
                                },
                                child: Icon(
                                  showNewPasswordUser ? Icons.visibility : Icons.visibility_off,
                                  color: Palette.appBarColor,
                                ),
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
                            obscureText: !showConfirmPasswordUser,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  toggleConfirmPasswordVisibility();
                                },
                                child: Icon(
                                  showConfirmPasswordUser ? Icons.visibility : Icons.visibility_off,
                                  color: Palette.appBarColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                sizeBox30h,
                Container(
                  height: 50.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Palette.buttonBackgroundColor,
                  ),
                  child: TextButton(
                    onPressed: _changePassword,
                    child: isLoading == false
                        ? Text(
                            'UPDATE PASSWORD',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          )
                        : const CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _changePassword() async {
    if (oldPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (oldPasswordController.text.length < 12 &&
          newPasswordController.text.length < 12 &&
          confirmPasswordController.text.length < 12) {
        Utils.showToast("Password must be 12 character");
      } else if (oldPasswordController.text.length < 12 && newPasswordController.text.length < 12) {
        Utils.showToast("Old password and new password must be 12 character");
      } else if (oldPasswordController.text.length < 12 && confirmPasswordController.text.length < 12) {
        Utils.showToast("Old password and confirm password must be 12 character");
      } else if (newPasswordController.text.length < 12 && confirmPasswordController.text.length < 12) {
        Utils.showToast("New password and confirm password must be 12 character");
      } else if (oldPasswordController.text.length < 12) {
        Utils.showToast("Old password must be 12 character");
      } else if (newPasswordController.text.length < 12) {
        Utils.showToast("New password must be 12 character");
      } else if (confirmPasswordController.text.length < 12) {
        Utils.showToast("Confirm password must be 12 character");
      } else if (oldPasswordController.text == newPasswordController.text) {
        Utils.showToast("Old password and new password should be not same");
      } else if (newPasswordController.text != confirmPasswordController.text) {
        Utils.showToast("New password and confirm password should be same");
      } else {
        Utils.unFocus(context);
        isLoading = true;

        final changePasswordJson = {
          "OldPassword": oldPasswordController.text,
          "NewPassword": confirmPasswordController.text,
        };

        final response = await changePassword(body: changePasswordJson);
        if (response.statusCode == 201) {
          Navigator.pop(context);
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return buildSingleButtonPopupDialog(
                    context: context,
                    icon: Icons.check_circle_outline_rounded,
                    mainText: "Changed!",
                    text: "Password Changed Successfully.",
                    onPressed: () async {
                      kSharedPreferences.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                      await FlutterRestart.restartApp();
                    });
              });
        } else if (response.statusCode == 404) {
          Navigator.pop(context);
          unAuthenticationDialog(context);
        } else {
          log(response.reasonPhrase);
        }
        isLoading = false;
      }
    } else {
      if (oldPasswordController.text.isEmpty && newPasswordController.text.isEmpty && confirmPasswordController.text.isEmpty) {
        Utils.showToast("Please enter detail");
      } else if (oldPasswordController.text.isEmpty && newPasswordController.text.isEmpty) {
        Utils.showToast("Please enter old password and new password");
      } else if (oldPasswordController.text.isEmpty && confirmPasswordController.text.isEmpty) {
        Utils.showToast("Please enter old password and confirm password");
      } else if (newPasswordController.text.isEmpty && confirmPasswordController.text.isEmpty) {
        Utils.showToast("Please enter new password and confirm password");
      } else if (oldPasswordController.text.isEmpty) {
        Utils.showToast("Please enter old password");
      } else if (newPasswordController.text.isEmpty) {
        Utils.showToast("Please enter new password");
      } else {
        Utils.showToast("Please enter confirm password");
      }
    }
  }
}
