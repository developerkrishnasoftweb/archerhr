import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/model/getleave_byid_model.dart';
import 'package:archerhr_mobile/model/leave_data_model.dart';
import 'package:archerhr_mobile/provider/get_leave_provider.dart';
import 'package:archerhr_mobile/provider/leave_data_provider.dart';
import 'package:archerhr_mobile/screens/leave/widgets/full_day_leave.dart';
import 'package:archerhr_mobile/screens/leave/widgets/half_day_leave.dart';
import 'package:archerhr_mobile/screens/leave/widgets/update_full_day_leave.dart';
import 'package:archerhr_mobile/screens/leave/widgets/update_half_day_leave.dart';
import 'package:archerhr_mobile/screens/leave/widgets/watch_leave.dart';
import 'package:archerhr_mobile/screens/widgets/table_icon_tap.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({Key key}) : super(key: key);

  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  GetLeaveProvider getLeaveProvider;
  LeaveDataProvider leaveDataProvider;
  GetLeave getLeave = GetLeave();

  @override
  void initState() {
    super.initState();
    getLeaveProvider = Provider.of<GetLeaveProvider>(context, listen: false);

    leaveDataProvider = Provider.of<LeaveDataProvider>(context, listen: false);
    leaveDataProvider.clear();
    leaveDataProvider.getEmpLeaveData(context);
  }

  @override
  void dispose() {
    super.dispose();
    getLeaveProvider.clear();
    leaveDataProvider.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(232, 238, 240, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 0.h),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: SizedBox(
                  width: size.width,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.home,
                                  size: 20,
                                ),
                                sizeBox5w,
                                Text(
                                  "My Leaves",
                                  style: TextStyle(
                                    fontSize: 14.h,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                          sizeBox10h,
                          Consumer<LeaveDataProvider>(builder: (context, provider, child) {
                            if (provider.loading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Palette.circularProgress,
                                ),
                              );
                            }
                            if (provider.leaveAvailList.isNotEmpty) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Casual Leaves ${provider.leaveAvailList[0].leaveConsumed.toString().split(".0").first}/${int.parse(provider.leaveAvailList[0].leaveTotal.toString().split(".").first)}",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                                    child: LinearPercentIndicator(
                                      animation: true,
                                      animationDuration: 1000,
                                      lineHeight: 10.h,
                                      percent: provider.leaveAvailList[0].leaveConsumed / provider.leaveAvailList[0].leaveTotal,
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Colors.blue[400],
                                      backgroundColor: Colors.grey[300],
                                    ),
                                  ),
                                  sizeBox10h,
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Sick Leaves ${provider.leaveAvailList[1].leaveConsumed.toString().split(".0").first}/${int.parse(provider.leaveAvailList[1].leaveTotal.toString().split(".").first)}",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                                    child: LinearPercentIndicator(
                                      animation: true,
                                      animationDuration: 1000,
                                      lineHeight: 10.h,
                                      percent: provider.leaveAvailList[1].leaveConsumed / provider.leaveAvailList[1].leaveTotal,
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Colors.orange[400],
                                      backgroundColor: Colors.grey[300],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Text(
                                "No Data Found",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 0.h, 5.w, 20.h),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: SizedBox(
                  width: size.width,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Consumer<LeaveDataProvider>(builder: (context, provider, child) {
                        if (provider.loading) {
                          return const CircularProgressIndicator(
                            color: Palette.circularProgress,
                          );
                        }
                        if (provider.empList.isNotEmpty) {
                         int _rowsPerPage = provider.empList.length > 5 ? 5 : provider.empList.length;
                          /// Set default number of rows to be displayed per page
                          //var _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
                          return PaginatedDataTable(
                            source: LeaveSource(empList: provider.empList, context: context, leaveDataProvider: provider),
                            rowsPerPage: _rowsPerPage,
                            showFirstLastButtons: true,
                            headingRowHeight: 40,
                            columnSpacing: 10,
                            horizontalMargin: 10,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(' '),
                              ),
                              DataColumn(
                                label: Text('Status'),
                              ),
                              DataColumn(
                                label: Text('Id'),
                              ),
                              DataColumn(
                                label: Text('Type'),
                              ),
                              DataColumn(
                                label: Text('From'),
                              ),
                              DataColumn(
                                label: Text('To'),
                              ),
                            ],
                          );
                        } else {
                          return Text(
                            "No Data Found",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          );
                        }
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: PopupMenuButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            //size: 30,
          ),
          onSelected: (select) {
            if (select == 1) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => FullDayLeaveScreen(
                  leaveDataProvider: leaveDataProvider,
                ),
              );
            } else {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => HalfDayLeaveScreen(
                  leaveDataProvider: leaveDataProvider,
                ),
              );
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () {},
                value: 1,
                child: Text(
                  'Full day',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
              PopupMenuItem(
                onTap: () {},
                value: 2,
                child: Text(
                  'Half day',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ];
          },
        ),
        backgroundColor: Colors.green,
        onPressed: () {},
      ),
    );
  }
}

class LeaveSource extends DataTableSource {
  List<EmpLeaveList> empList;
  BuildContext context;
  LeaveDataProvider leaveDataProvider;

  LeaveSource({this.empList, this.context, this.leaveDataProvider});

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => empList.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        empList[index].statusId == 3 || empList[index].statusId == 4
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TableIconTap(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) => WatchLeaveScreen(
                          leaveDataProvider: leaveDataProvider,
                          id: empList[index].id,
                        ),
                      );
                    },
                    icon: Icons.remove_red_eye_rounded,
                    color: Palette.buttonBackgroundColor,
                  ),
                ],
              )
            : Row(
                children: [
                  TableIconTap(
                    onTap: () async {
                      if (empList[index].leaveCategoryId == 1) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => UpdateFullDay(
                            leaveDataProvider: leaveDataProvider,
                            id: empList[index].id,
                          ),
                        );
                      } else {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => UpdateHalfDay(
                            leaveDataProvider: leaveDataProvider,
                            id: empList[index].id,
                          ),
                        );
                      }
                    },
                    icon: Icons.edit,
                    color: Colors.orange,
                  ),
                  sizeBox5w,
                  TableIconTap(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return buildDoubleButtonPopupDialog(
                            context: context,
                            icon: Icons.error_outline_rounded,
                            mainText: "Are you sure ?",
                            text: "You would not be able to revert this !",
                            onPressed: () async {
                              final response = await deleteLeaveId({'Id': '${empList[index].id}'});
                              if (response.statusCode == 200) {
                                Navigator.pop(context);
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return buildSingleButtonPopupDialog(
                                          icon: Icons.check_circle_outline_rounded,
                                          mainText: "Deleted!",
                                          text: "Your Leave Successfully Deleted.",
                                          onPressed: () {
                                            Navigator.pop(context);
                                            leaveDataProvider.empList.clear();
                                            leaveDataProvider.leaveAvailList.clear();
                                            leaveDataProvider.leaveTypeList.clear();
                                            leaveDataProvider.leaveCategoryList.clear();
                                            leaveDataProvider.getEmpLeaveData(context);
                                          });
                                    });
                              } else if (response.statusCode == 404) {
                                unAuthenticationDialog(context);
                              }
                            },
                          );
                        },
                      );
                    },
                    icon: Icons.close,
                    color: Colors.red,
                  ),
                ],
              ),
      ),
      DataCell(empList[index].statusId == 3
          ? approveStatus()
          : empList[index].statusId == 4
              ? rejectStatus()
              : appliedStatus()),
      DataCell(Text(empList[index].id.toString())),
      DataCell(Text(empList[index].leaveType)),
      DataCell(Text(empList[index].from)),
      DataCell(Text(empList[index].to)),
    ]);
  }
}
