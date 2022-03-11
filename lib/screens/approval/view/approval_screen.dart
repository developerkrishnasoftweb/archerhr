import 'package:archerhr_mobile/model/expense_approval_model.dart';
import 'package:archerhr_mobile/model/leave_approval_model.dart';
import 'package:archerhr_mobile/model/travel_approval_model.dart';
import 'package:archerhr_mobile/provider/expense_approval_provider.dart';
import 'package:archerhr_mobile/provider/leave_approval_provider.dart';
import 'package:archerhr_mobile/provider/travel_approval_provider.dart';
import 'package:archerhr_mobile/screens/approval/widgets/domestic_travel_approval.dart';
import 'package:archerhr_mobile/screens/approval/widgets/expense_approval.dart';
import 'package:archerhr_mobile/screens/approval/widgets/international_travel_approval.dart';
import 'package:archerhr_mobile/screens/approval/widgets/leave_approval.dart';
import 'package:archerhr_mobile/screens/widgets/table_icon_tap.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({Key key}) : super(key: key);

  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  LeaveApprovalProvider leaveApprovalProvider;
  ExpenseApprovalProvider expenseApprovalProvider;
  TravelApprovalProvider travelApprovalProvider;

  @override
  void initState() {
    super.initState();

    leaveApprovalProvider = Provider.of<LeaveApprovalProvider>(context, listen: false);
    leaveApprovalProvider.getLeaveApproval(context);

    expenseApprovalProvider = Provider.of<ExpenseApprovalProvider>(context, listen: false);
    expenseApprovalProvider.getExpenseApproval(context);

    travelApprovalProvider = Provider.of<TravelApprovalProvider>(context, listen: false);
    travelApprovalProvider.getTravelApproval(context);
  }

  @override
  void dispose() {
    super.dispose();
    leaveApprovalProvider.clear();
    expenseApprovalProvider.clear();
    travelApprovalProvider.clear();
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
              padding: EdgeInsets.only(left: 10.w, top: 10.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("LEAVE APPROVAL", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: SizedBox(
                  width: size.width,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Consumer<LeaveApprovalProvider>(builder: (context, provider, child) {
                        if (provider.loading) {
                          return const CircularProgressIndicator(
                            color: Palette.circularProgress,
                          );
                        }
                        if (provider.myLeaveApproval.isNotEmpty) {
                          return PaginatedDataTable(
                            source: LeaveApprovalSource(
                              leaveApproval: provider.myLeaveApproval,
                              context: context,
                              leaveApprovalProvider: provider,
                            ),
                            rowsPerPage: provider.myLeaveApproval.length > 5 ? 5 : provider.myLeaveApproval.length,
                            showFirstLastButtons: true,
                            headingRowHeight: 40,
                            columnSpacing: 10,
                            horizontalMargin: 10,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: SizedBox(),
                              ),
                              DataColumn(
                                label: Text('Id'),
                              ),
                              DataColumn(
                                label: Text('Category'),
                              ),
                              DataColumn(
                                label: Text('Type'),
                              ),
                              DataColumn(
                                label: Text('From Date'),
                              ),
                              DataColumn(
                                label: Text('To Date'),
                              ),
                              DataColumn(
                                label: Text('Applied By'),
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
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("TRAVEL APPROVAL", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: SizedBox(
                  width: size.width,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Consumer<TravelApprovalProvider>(
                        builder: (context, provider, child) {
                          if (provider.loading) {
                            return const CircularProgressIndicator(
                              color: Palette.circularProgress,
                            );
                          }
                          if (provider.myTravelApproval.isNotEmpty) {
                            return PaginatedDataTable(
                              source: TravelApprovalSource(travelList: provider.myTravelApproval, context: context),
                              rowsPerPage: provider.myTravelApproval.length > 5 ? 5 : provider.myTravelApproval.length,
                              showFirstLastButtons: true,
                              headingRowHeight: 40,
                              columnSpacing: 10,
                              horizontalMargin: 10,
                              columns: const [
                                DataColumn(label: Text('')),
                                DataColumn(
                                  label: Text('Id'),
                                ),
                                DataColumn(
                                  label: Text('Type'),
                                ),
                                DataColumn(
                                  label: Text('Travel Date'),
                                ),
                                DataColumn(
                                  label: Text('Return Date'),
                                ),
                                DataColumn(
                                  label: Text('Applied By'),
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
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("EXPENSE APPROVAL", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300)),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 20.h),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: SizedBox(
                      width: size.width,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          child: Consumer<ExpenseApprovalProvider>(
                            builder: (context, provider, child) {
                              if (provider.loading) {
                                return const CircularProgressIndicator(
                                  color: Palette.circularProgress,
                                );
                              }
                              if (provider.myExpenseApproval.isNotEmpty) {
                                return PaginatedDataTable(
                                  source: ExpenseApprovalSource(
                                      expenseApproval: provider.myExpenseApproval,
                                      context: context,
                                      expenseApprovalProvider: provider),
                                  columnSpacing: 30,
                                  rowsPerPage: provider.myExpenseApproval.length > 5 ? 5 : provider.myExpenseApproval.length,
                                  horizontalMargin: 20,
                                  headingRowHeight: 40,
                                  showFirstLastButtons: true,
                                  columns: const [
                                    DataColumn(
                                      label: Text(''),
                                    ),
                                    DataColumn(
                                      label: Text('Id'),
                                    ),
                                    DataColumn(
                                      label: Text('Applied Date'),
                                    ),
                                    DataColumn(
                                      label: Text('Applied By'),
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
                            },
                          ),
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}

class LeaveApprovalSource extends DataTableSource {
  List<MyAprLeaveList> leaveApproval;
  BuildContext context;
  LeaveApprovalProvider leaveApprovalProvider;

  LeaveApprovalSource({this.leaveApproval, this.context, this.leaveApprovalProvider});

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Row(
          children: [
            TableIconTap(
              onTap: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) =>
                      LeaveApprovalScreen(id: leaveApproval[index].id, leaveApprovalProvider: leaveApprovalProvider),
                );
              },
              icon: Icons.check_box_outlined,
              color: Colors.cyan,
            ),
          ],
        ),
      ),
      DataCell(Text('${leaveApproval[index].id}')),
      DataCell(Text(leaveApproval[index].category)),
      DataCell(Text(leaveApproval[index].leaveType)),
      DataCell(Text(leaveApproval[index].from)),
      DataCell(Text(leaveApproval[index].to)),
      DataCell(Text(leaveApproval[index].firstName + "," + leaveApproval[index].lastName)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => leaveApproval.length;

  @override
  int get selectedRowCount => 0;
}

class TravelApprovalSource extends DataTableSource {
  List<MyAprTravelList> travelList;
  BuildContext context;

  TravelApprovalSource({this.travelList, this.context});

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Row(
          children: [
            TableIconTap(
              onTap: () {
                if (travelList[index].travelTypeId == 1) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => DomesticTravelApprovalScreen(id: travelList[index].id),
                  );
                } else {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => InternationalTravelApprovalScreen(id: travelList[index].id),
                  );
                }
              },
              icon: Icons.check_box_outlined,
              color: Colors.cyan,
            ),
          ],
        ),
      ),
      DataCell(Text('${travelList[index].id}')),
      DataCell(travelList[index].travelTypeId == 1 ? const Text("Dom") : const Text("Int")),
      DataCell(Text(travelList[index].travelDate)),
      DataCell(Text(travelList[index].returnDate)),
      DataCell(Text(travelList[index].firstName + "," + travelList[index].lastName)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => travelList.length;

  @override
  int get selectedRowCount => 0;
}

class ExpenseApprovalSource extends DataTableSource {
  List<MyExpenseAprlReq> expenseApproval;
  ExpenseApprovalProvider expenseApprovalProvider;
  BuildContext context;

  ExpenseApprovalSource({this.expenseApproval, this.context, this.expenseApprovalProvider});

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Row(
          children: [
            TableIconTap(
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) =>
                      ExpenseApprovalScreen(id: expenseApproval[index].id, expenseApprovalProvider: expenseApprovalProvider),
                );
              },
              icon: Icons.check_box_outlined,
              color: Colors.cyan,
            ),
          ],
        ),
      ),
      DataCell(Text('${expenseApproval[index].id}')),
      DataCell(Text(expenseApproval[index].appliedDate)),
      DataCell(Text(expenseApproval[index].firstName + "," + expenseApproval[index].lastName)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => expenseApproval.length;

  @override
  int get selectedRowCount => 0;
}
