import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/provider/connectivity_provider.dart';
import 'package:archerhr_mobile/provider/dashboard_provider.dart';
import 'package:archerhr_mobile/provider/directory_data_byid_provider.dart';
import 'package:archerhr_mobile/provider/directory_list_data_provider.dart';
import 'package:archerhr_mobile/provider/expense_approval_provider.dart';
import 'package:archerhr_mobile/provider/expense_data_provider.dart';
import 'package:archerhr_mobile/provider/expense_list_data_provider.dart';
import 'package:archerhr_mobile/provider/get_expense_provider.dart';
import 'package:archerhr_mobile/provider/get_leave_provider.dart';
import 'package:archerhr_mobile/provider/get_travel_provider.dart';
import 'package:archerhr_mobile/provider/leave_approval_provider.dart';
import 'package:archerhr_mobile/provider/leave_data_provider.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:archerhr_mobile/provider/travel_approval_provider.dart';
import 'package:archerhr_mobile/provider/travel_data_provider.dart';
import 'package:archerhr_mobile/provider/travel_list_data_provider.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/screens/dashboard/view/dashboard_screen.dart';
import 'package:archerhr_mobile/utils/services/background_services.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  await Future.delayed(const Duration(seconds: 1));
  kSharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // material nav key
  static GlobalKey<NavigatorState> materialNavKey = GlobalKey<NavigatorState>();

  static bool get _isAuthenticated {
    var userCookie = kSharedPreferences.getString("Cookie");
    return userCookie != null && userCookie.isNotEmpty;
  }

  const MyApp({Key key}) : super(key: key);

  final textScaleFactor = 1.0;
  final kMontserrat = "Montserrat";

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider<ConnectivityProvider>(create: (context) => ConnectivityProvider()),
          ChangeNotifierProvider<GetLeaveProvider>(create: (context) => GetLeaveProvider()),
          ChangeNotifierProvider<LeaveDataProvider>(create: (context) => LeaveDataProvider()),
          ChangeNotifierProvider<TravelDataProvider>(create: (context) => TravelDataProvider()),
          ChangeNotifierProvider<GetTravelProvider>(create: (context) => GetTravelProvider()),
          ChangeNotifierProvider<TravelListDataProvider>(create: (context) => TravelListDataProvider()),
          ChangeNotifierProvider<ExpenseListDataProvider>(create: (context) => ExpenseListDataProvider()),
          ChangeNotifierProvider<ExpenseDataProvider>(create: (context) => ExpenseDataProvider()),
          ChangeNotifierProvider<GetExpenseProvider>(create: (context) => GetExpenseProvider()),
          ChangeNotifierProvider<LeaveApprovalProvider>(create: (context) => LeaveApprovalProvider()),
          ChangeNotifierProvider<ExpenseApprovalProvider>(create: (context) => ExpenseApprovalProvider()),
          ChangeNotifierProvider<DashboardProvider>(create: (context) => DashboardProvider()),
          ChangeNotifierProvider<ProfileProvider>(create: (context) => ProfileProvider()),
          ChangeNotifierProvider<TravelApprovalProvider>(create: (context) => TravelApprovalProvider()),
          ChangeNotifierProvider<GetDirectoryListProvider>(create: (context) => GetDirectoryListProvider()),
          ChangeNotifierProvider<GetDirectoryByIdProvider>(create: (context) => GetDirectoryByIdProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: TextTheme(
              bodyText2: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
              headline1: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
              bodyText1: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
              button: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
              caption: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
              headline2: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
              headline3: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
              headline4: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
              headline5: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
              headline6: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
              overline: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
              subtitle1: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
              subtitle2: TextStyle(
                height: textScaleFactor,
                fontFamily: kMontserrat,
              ),
            ),
          ),
          home: _isAuthenticated == true ? DashboardScreen() : const LoginScreen(),
        ),
      ),
    );
  }
}
