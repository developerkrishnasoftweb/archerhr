import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/screens/dashboard/view/dashboard_screen.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/archer_logo.png",
                  height: 50.h,
                ),
                SizedBox(height: 40.h),
                Container(
                  height: 60.h,
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: ' Login ID',
                      labelText: 'LOGIN ID',
                      labelStyle: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: const Icon(Icons.person_outline_outlined),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 60.h,
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outlined),
                      border: const OutlineInputBorder(),
                      hintText: 'PASSWORD',
                      hintStyle: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 50.h,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  child: TextButton(
                    onPressed: _login,
                    child: isLoading == false
                        ? Text(
                            "LOGIN",
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

  void _login() async {
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      // unFocus keyboard
      Utils.unFocus(context);

      isLoading = true;

      final response = await login(
        usernameController.text,
        passwordController.text,
      );
      if (response.statusCode == 200) {
        await kSharedPreferences.setString("Cookie", response.headers["set-cookie"] + ";");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => DashboardScreen(),
            ));
      } else if (response.statusCode == 401) {
        setState(() {
          isLoading = false;
        });
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return buildSingleButtonPopupDialog(
                  icon: Icons.warning_amber_rounded,
                  iconColor: Colors.red,
                  mainText: "Unauthorized!",
                  text: "Authentication failed,please login again",
                  onPressed: () {
                    Navigator.pop(context);
                  });
            });
      }
      isLoading = false;
    } else {
      Utils.showToast("Please enter username and password");
    }
  }
}
