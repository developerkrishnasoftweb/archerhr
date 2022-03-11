import 'dart:async';
import 'dart:developer';

import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/connectivity_provider.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:archerhr_mobile/screens/approval/view/approval_screen.dart';
import 'package:archerhr_mobile/screens/auth/changepassword/change_password_screen.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/screens/company/view/company_screen.dart';
import 'package:archerhr_mobile/screens/directory/view/directory_list.dart';
import 'package:archerhr_mobile/screens/expense/view/expense_screen.dart';
import 'package:archerhr_mobile/screens/home/view/home_screen.dart';
import 'package:archerhr_mobile/screens/leave/view/leave_screen.dart';
import 'package:archerhr_mobile/screens/profile/view/profile_screen.dart';
import 'package:archerhr_mobile/screens/travel/view/travel_screen.dart';
import 'package:archerhr_mobile/screens/widgets/no_internet_dialog.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  int selectedPage;

  DashboardScreen({Key key, this.selectedPage}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  ProfileProvider profileProvider;
  ConnectivityProvider _connectivityProvider;
  bool _isShowingNoInternetDialog = false;
  var lat = "latitude";
  var long = "longitude";
  var locationName = "";
  var subLocationName = "";
  Timer _timer;
  Duration _duration = const Duration();
  final dragController = DragController();

  int selected = 0;
  int punchingId;
  int navigateSelectedPage;
  bool isLoading = false;
  bool isPunched = false;
  bool showTimer = false;
  bool responseBool;

  navigatePage() {
    if (widget.selectedPage != null) {
      navigateSelectedPage = widget.selectedPage;
    } else {
      navigateSelectedPage = 0;
    }
  }

  void getCurrentLocation() async {
    LocationPermission per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied || per == LocationPermission.deniedForever) {
      log("permission denied");
      LocationPermission per1 = await Geolocator.requestPermission();

      if (per1 != null) {
        Position currentLoc = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
        List<Placemark> placeMark = await placemarkFromCoordinates(currentLoc.latitude, currentLoc.longitude);
        Placemark place = placeMark[0];
        setState(() {
          lat = currentLoc.latitude.toString();
          long = currentLoc.longitude.toString();
          locationName = place.locality;
          subLocationName = place.subLocality;

          log(lat);
          log(long);
          log(locationName);
          log(subLocationName);
        });
      }
    } else {
      Position currentLoc = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      List<Placemark> placeMark = await placemarkFromCoordinates(currentLoc.latitude, currentLoc.longitude);
      Placemark place = placeMark[0];
      setState(() {
        lat = currentLoc.latitude.toString();
        long = currentLoc.longitude.toString();
        locationName = place.locality;
        subLocationName = place.subLocality;

        log(lat);
        log(long);
        log(locationName);
        log(subLocationName);
      });
    }
  }

  _empPunchIn() async {
    isLoading = true;
    if (kSharedPreferences.getString("PunchingId") == null) {
      if (subLocationName.isNotEmpty || locationName.isNotEmpty && lat.isNotEmpty && long.isNotEmpty) {
        final punchJson = {"start_city": subLocationName + "," + locationName, "start_latit": lat, "start_longt": long};
        final response = await punchIn(body: punchJson);

        if (response.statusCode == 200 && response.data.id != null) {
          kSharedPreferences.setString("PunchingId", response.data.id.toString());
          log("Start Punch : ${kSharedPreferences.getString("PunchingId")}");
          showTimer = true;
          if (isPunched == false) {
            isPunched = true;
            FlutterBackgroundService().sendData({"action": "tick"});
          }
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return buildSingleButtonPopupDialog(
                    context: context,
                    icon: Icons.location_on_rounded,
                    mainText: "Punched",
                    text: "Punch In Successfully.",
                    onPressed: () {
                      Navigator.pop(context);
                    });
              });
        } else if (response.statusCode == 404) {
          unAuthenticationDialog(context);
        } else {
          log(response.message);
        }
        isLoading = false;
      } else {
        Utils.showToast("Location Not Found");
      }
    } else {
      log("End Time punching id : ${kSharedPreferences.getString("PunchingId")}");
      if (kSharedPreferences.getString("PunchingId") != null && subLocationName.isNotEmpty ||
          locationName.isNotEmpty && lat.isNotEmpty && long.isNotEmpty) {
        final punchJson = {
          "Id": kSharedPreferences.getString("PunchingId"),
          "end_city": subLocationName + "," + locationName,
          "end_latit": lat,
          "end_longt": long
        };

        final response = await punchOut(body: punchJson);
        if (response.statusCode == 200) {
          isPunched = false;
          FlutterBackgroundService().sendData({"action": "stop"});
          _duration = const Duration();
          kSharedPreferences.remove("PunchingId");
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return buildSingleButtonPopupDialog(
                    context: context,
                    icon: Icons.location_on_rounded,
                    mainText: "Punch Out",
                    text: "Punch Out Successfully.",
                    onPressed: () {
                      Navigator.pop(context);
                    });
              });
        } else if (response.statusCode == 404) {
          unAuthenticationDialog(context);
        } else {
          log(response.reasonPhrase);
        }
        isLoading = false;
      } else {
        Utils.showToast("Location Not Found");
      }
    }
  }

  // show dialog if there is noInternetConnection
  void _noInternetConnectionDialog() async {
    if (_connectivityProvider.connectivityResult == ConnectivityResult.none) {
      _isShowingNoInternetDialog = true;
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const NoInternetDialog(),
      );
      _isShowingNoInternetDialog = false;
    } else {
      if (_isShowingNoInternetDialog) {
        _isShowingNoInternetDialog = false;
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    navigatePage();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getProfile(context);
    getCurrentLocation();

    //log(kSharedPreferences.getString("PunchingId"));

    /*/// initialize [_connectivityProvider]
    _connectivityProvider =
        Provider.of<ConnectivityProvider>(context, listen: false);

    /// Initialize [_connectivityProvider]
    _connectivityProvider.initialize();

    /// Listening for connectivity if it changes
    _connectivityProvider.addListener(_noInternetConnectionDialog);*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Palette.appBackground,
      drawer: Drawer(
        child: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Image.asset(
                        "assets/images/archer_logo.png",
                        height: 30.h,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, left: 20.w, bottom: 20.h),
                      child: Container(
                        height: 55.h,
                        width: 55.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/baby.jpeg"),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    sizeBox5w,
                    provider.profileModel.employeeDet.firstName.isNotEmpty
                        ? Text(
                            provider.loading ? "Loading" : provider.profileModel.employeeDet.firstName,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                              color: Colors.grey,
                            ),
                          )
                        : Text(
                            "Not Found",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                              color: Colors.grey,
                            ),
                          ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 0;
                    });
                  },
                  child: Container(
                    color: selected == 0 ? Palette.selectedDrawerTabColor : Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 7.0,
                          ),
                          child: Builder(
                            builder: (context) => IconButton(
                              icon: Image.asset(
                                "assets/images/home.png",
                                color: selected == 0 ? Colors.white : Colors.grey,
                              ),
                              onPressed: () => Scaffold.of(context).openDrawer(),
                            ),
                          ),
                        ),
                        Text(
                          "HOME",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: selected == 0 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 1;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(
                          selectedPage: 2,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: selected == 1 ? Palette.selectedDrawerTabColor : Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 7.0,
                          ),
                          child: Builder(
                            builder: (context) => IconButton(
                              icon: Image.asset(
                                "assets/images/wallet.png",
                                color: selected == 1 ? Colors.white : Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Text(
                          "EXPENSE",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: selected == 1 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 2;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(
                          selectedPage: 1,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: selected == 2 ? Palette.selectedDrawerTabColor : Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 7.0,
                          ),
                          child: Builder(
                            builder: (context) => IconButton(
                              icon: Image.asset(
                                "assets/images/thumb.png",
                                color: selected == 2 ? Colors.white : Colors.grey,
                              ),
                              onPressed: () => Scaffold.of(context).openDrawer(),
                            ),
                          ),
                        ),
                        Text(
                          "ATTENDANCE AND LEAVE",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: selected == 2 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 3;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(
                          selectedPage: 3,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: selected == 3 ? Palette.selectedDrawerTabColor : Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 7.0,
                          ),
                          child: Builder(
                            builder: (context) => IconButton(
                              icon: Image.asset(
                                "assets/images/plane.png",
                                color: selected == 3 ? Colors.white : Colors.grey,
                              ),
                              onPressed: () => Scaffold.of(context).openDrawer(),
                            ),
                          ),
                        ),
                        Text(
                          "TRAVEL",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: selected == 3 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 4;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CompanyScreen()),
                    );
                  },
                  child: Container(
                    color: selected == 4 ? Palette.selectedDrawerTabColor : Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 7.0,
                          ),
                          child: Builder(
                            builder: (context) => IconButton(
                              icon: Image.asset(
                                "assets/images/company.png",
                                color: selected == 4 ? Colors.white : Colors.grey,
                              ),
                              onPressed: () => Scaffold.of(context).openDrawer(),
                            ),
                          ),
                        ),
                        Text(
                          "COMPANY",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: selected == 4 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 5;
                    });
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmployeesList(),
                      ),
                    );
                  },
                  child: Container(
                    color: selected == 5 ? Palette.selectedDrawerTabColor : Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 7.0,
                          ),
                          child: Builder(
                            builder: (context) => IconButton(
                              icon: Image.asset(
                                "assets/images/hand.png",
                                color: selected == 5 ? Colors.white : Colors.grey,
                              ),
                              onPressed: () => Scaffold.of(context).openDrawer(),
                            ),
                          ),
                        ),
                        Text(
                          "DIRECTORY",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: selected == 5 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 6;
                    });
                  },
                  child: Container(
                    color: selected == 6 ? Palette.selectedDrawerTabColor : Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 7.0,
                          ),
                          child: Builder(
                            builder: (context) => IconButton(
                              icon: Image.asset(
                                "assets/images/hand.png",
                                color: selected == 6 ? Colors.white : Colors.grey,
                              ),
                              onPressed: () => Scaffold.of(context).openDrawer(),
                            ),
                          ),
                        ),
                        Text(
                          "REQUESTS",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: selected == 6 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Palette.appBarColor,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Builder(
            builder: (context) => IconButton(
              icon: Image.asset("assets/images/drawer.png"),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        title: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            return Row(
              children: [
                Container(
                  height: 45.h,
                  width: 45.w,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/baby.jpeg"),
                      //image: NetworkImage(Urls.baseUrl +"/"+ provider.profileModel.employeeDet.photoName),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120.w,
                      child: Text(
                        provider.loading ? "Loading" : provider.profileModel.employeeDet.firstName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    sizeBox5h,
                    StreamBuilder<Map<String, dynamic>>(
                        stream: FlutterBackgroundService().onDataReceived,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }
                          var duration = const Duration();
                          if (snapshot.data['tick'] != null) {
                            duration = Duration(seconds: snapshot.data['tick']);
                          } else if (snapshot.data['stop'] != null) {
                            duration = Duration(seconds: snapshot.data['stop']);
                          }
                          return Text(
                            "${NumberFormat("##00", "en_US").format(duration.inHours % 60)}:"
                            "${NumberFormat("##00", "en_US").format(duration.inMinutes % 60)}:"
                            "${NumberFormat("##00", "en_US").format(duration.inSeconds % 60)}",
                            style: TextStyle(fontSize: 16.sp),
                          );
                        })
                  ],
                ),
              ],
            );
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                "assets/images/punch.png",
                height: 30.h,
                width: 20.w,
              ),
              onPressed: _empPunchIn,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.notifications_none_outlined,
              size: 30,
            ),
          ),
          PopupMenuButton<int>(
            padding: EdgeInsets.zero,
            elevation: 20,
            shape: const OutlineInputBorder(borderSide: BorderSide(color: Palette.appBarColor, width: 1)),
            icon: const Icon(
              Icons.more_vert_rounded,
              size: 30,
            ),
            onSelected: (int value) {
              if (value == 0) {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              } else if (value == 1) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => const ChangePasswordScreen(),
                );
              } else if (value == 2) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return buildDoubleButtonPopupDialog(
                          context: context,
                          icon: Icons.logout_rounded,
                          mainText: "Logout",
                          text: "Are you sure that you want to logout?",
                          buttonName: "YES, LOGOUT",
                          onPressed: () async {
                            await kSharedPreferences.remove("Cookie");
                            await kSharedPreferences.clear();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                              (Route<dynamic> route) => false,
                            );
                            await FlutterRestart.restartApp();
                            //await Phoenix.rebirth(context);
                          });
                    });
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'My Profile',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Change Password',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'LogOut',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: DefaultTabController(
        initialIndex: navigateSelectedPage,
        length: 5,
        child: Column(
          children: [
            Container(
              color: Palette.appBarColor,
              child: const TabBar(
                labelColor: Colors.white,
                isScrollable: true,
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(color: Palette.selectedTabBar),
                tabs: [
                  Tab(text: 'DASHBOARD'),
                  Tab(text: 'LEAVE'),
                  Tab(text: 'EXPENSE'),
                  Tab(text: 'TRAVEL'),
                  Tab(text: 'APPROVAL'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(children: [
                HomeScreen(),
                LeaveScreen(),
                ExpenseScreen(),
                TravelScreen(),
                ApprovalScreen(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
