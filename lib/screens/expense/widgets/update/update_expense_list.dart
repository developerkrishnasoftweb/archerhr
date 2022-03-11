import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/expense_data_provider.dart';
import 'package:archerhr_mobile/provider/expense_list_data_provider.dart';
import 'package:archerhr_mobile/provider/get_expense_provider.dart';
import 'package:archerhr_mobile/screens/expense/widgets/create_expense.dart';
import 'package:archerhr_mobile/screens/expense/widgets/update/update_fixed_allowance_expense.dart';
import 'package:archerhr_mobile/screens/expense/widgets/update/update_fuel_expense.dart';
import 'package:archerhr_mobile/screens/expense/widgets/update/update_hotel_stay_expense.dart';
import 'package:archerhr_mobile/screens/expense/widgets/update/update_mobiledata_expense.dart';
import 'package:archerhr_mobile/screens/expense/widgets/update/update_other_expense.dart';
import 'package:archerhr_mobile/screens/expense/widgets/update/update_travel_expense.dart';
import 'package:archerhr_mobile/screens/widgets/table_icon_tap.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UpdateExpenseList extends StatefulWidget {
  UpdateExpenseList({Key key, this.id, this.expenseListDataProvider,this.expenseDataProvider}) : super(key: key);
  int id;
  ExpenseListDataProvider expenseListDataProvider;
  ExpenseDataProvider expenseDataProvider;

  @override
  _UpdateExpenseListState createState() => _UpdateExpenseListState();
}

class _UpdateExpenseListState extends State<UpdateExpenseList> {
  GetExpenseProvider getExpenseProvider;
  ExpenseListDataProvider expenseListDataProvider;

  @override
  void initState() {
    super.initState();
    getExpenseProvider = Provider.of<GetExpenseProvider>(context, listen: false);
    getExpenseProvider.getExpenseData(context, widget.id);

    expenseListDataProvider = widget.expenseListDataProvider;
  }

  @override
  void dispose() {
    super.dispose();
    getExpenseProvider.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetExpenseProvider>(builder: (context, provider, child) {
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        titlePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  "CLAIM ID : ${widget.id}",
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TableIconTap(
                    onTap: () async {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) =>
                            CreateExpense(id: widget.id, expenseListDataProvider: widget.expenseListDataProvider,expenseDataProvider: widget.expenseDataProvider),
                      );
                      provider.clear();
                    },
                    icon: Icons.add,
                    color: Colors.green,
                  ),
                ),
                sizeBox20h,
                if (provider.loading)
                  const CircularProgressIndicator(color: Palette.circularProgress)
                else
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.expenseList.map((e) => e.catId).toSet().length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (provider.expenseList[index].catId == 1)
                              Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        provider.expenseTypeList[index].catName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      columns: const <DataColumn>[
                                        DataColumn(
                                          label: Text('Name'),
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
                                          label: Text('Amount'),
                                        ),
                                        DataColumn(
                                          label: Text('Comment'),
                                        ),
                                        DataColumn(
                                          label: Text(' '),
                                        ),
                                      ],
                                      rows: provider.expenseList
                                          .where((category) => category.catId == 1)
                                          .map(
                                            (e) => DataRow(cells: [
                                              DataCell(Text(e.expenseName)),
                                              DataCell(Text(e.expenseTypeName)),
                                              DataCell(Text(e.fromDt)),
                                              DataCell(Text(e.toDt)),
                                              DataCell(Text('${e.amount}')),
                                              DataCell(Text(e.comments)),
                                              DataCell(
                                                Row(
                                                  children: [
                                                    TableIconTap(
                                                      onTap: () async {
                                                        showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext context) => UpdateFixedAllowanceScreen(
                                                              getExpenseProvider: getExpenseProvider,
                                                              id: widget.id,
                                                              expenseListIndex: index,
                                                              expenseListId: e.id,
                                                              expenseDataProvider: widget.expenseDataProvider,
                                                          ),
                                                        );
                                                        provider.clear();
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
                                                                final response = await deleteExpenseListId({'Id': '${e.id}'});
                                                                if (response.statusCode == 200) {
                                                                  Navigator.pop(context);
                                                                  showDialog(
                                                                      barrierDismissible: false,
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return buildSingleButtonPopupDialog(
                                                                            icon: Icons.check_circle_outline_rounded,
                                                                            mainText: "Deleted!",
                                                                            text: "Your Travel Successfully Deleted.",
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                              provider.clear();
                                                                              provider.getExpenseData(context, widget.id);
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
                                            ]),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  sizeBox10h
                                ],
                              )
                            else if (provider.expenseList[index].catId == 2)
                              Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        provider.expenseTypeList[index].catName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      columns: const <DataColumn>[
                                        DataColumn(
                                          label: Text('Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Type'),
                                        ),
                                        DataColumn(
                                          label: Text('Date'),
                                        ),
                                        DataColumn(
                                          label: Text('Amount'),
                                        ),
                                        DataColumn(
                                          label: Text('Comment'),
                                        ),
                                        DataColumn(
                                          label: Text(' '),
                                        ),
                                      ],
                                      rows: provider.expenseList
                                          .where((category) => category.catId == 2)
                                          .map(
                                            (e) => DataRow(cells: [
                                              DataCell(Text(e.expenseName)),
                                              DataCell(Text(e.expenseTypeName)),
                                              DataCell(Text(e.fromDt)),
                                              DataCell(Text('${e.amount}')),
                                              DataCell(Text(e.comments)),
                                              DataCell(
                                                Row(
                                                  children: [
                                                    TableIconTap(
                                                      onTap: () async {
                                                        showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext context) => UpdateTravelExpenseScreen(
                                                              getExpenseProvider: getExpenseProvider,
                                                              id: widget.id,
                                                              expenseListIndex: index,
                                                              expenseListId: e.id,
                                                              expenseDataProvider: widget.expenseDataProvider,
                                                          ),
                                                        );
                                                        provider.clear();
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
                                                                final response = await deleteExpenseListId({'Id': '${e.id}'});
                                                                if (response.statusCode == 200) {
                                                                  Navigator.pop(context);
                                                                  showDialog(
                                                                      barrierDismissible: false,
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return buildSingleButtonPopupDialog(
                                                                            icon: Icons.check_circle_outline_rounded,
                                                                            mainText: "Deleted!",
                                                                            text: "Your Travel Successfully Deleted.",
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                              provider.clear();
                                                                              provider.getExpenseData(context, widget.id);
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
                                            ]),
                                          )
                                          .toSet()
                                          .toList(),
                                    ),
                                  ),
                                  sizeBox10h
                                ],
                              )
                            else if (provider.expenseList[index].catId == 3)
                              Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        provider.expenseTypeList[index].catName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      columns: const <DataColumn>[
                                        DataColumn(
                                          label: Text('Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Type'),
                                        ),
                                        DataColumn(
                                          label: Text('Date'),
                                        ),
                                        DataColumn(
                                          label: Text('Amount'),
                                        ),
                                        DataColumn(
                                          label: Text('Comment'),
                                        ),
                                        DataColumn(
                                          label: Text(' '),
                                        ),
                                      ],
                                      rows: provider.expenseList
                                          .where((category) => category.catId == 3)
                                          .map(
                                            (e) => DataRow(cells: [
                                              DataCell(Text(e.expenseName)),
                                              DataCell(Text(e.expenseTypeName)),
                                              DataCell(Text(e.fromDt)),
                                              DataCell(Text('${e.amount}')),
                                              DataCell(Text(e.comments)),
                                              DataCell(
                                                Row(
                                                  children: [
                                                    TableIconTap(
                                                      onTap: () async {
                                                        showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext context) => UpdateOtherExpenseScreen(
                                                              getExpenseProvider: getExpenseProvider,
                                                              id: widget.id,
                                                              expenseListIndex: index,
                                                              expenseListId: e.id),
                                                        );
                                                        provider.clear();
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
                                                                final response = await deleteExpenseListId({'Id': '${e.id}'});
                                                                if (response.statusCode == 200) {
                                                                  Navigator.pop(context);
                                                                  showDialog(
                                                                      barrierDismissible: false,
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return buildSingleButtonPopupDialog(
                                                                            icon: Icons.check_circle_outline_rounded,
                                                                            mainText: "Deleted!",
                                                                            text: "Your Travel Successfully Deleted.",
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                              provider.clear();
                                                                              provider.getExpenseData(context, widget.id);
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
                                            ]),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  sizeBox10h
                                ],
                              )
                            else if (provider.expenseList[index].catId == 4)
                              Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        provider.expenseTypeList[index].catName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      columns: const <DataColumn>[
                                        DataColumn(
                                          label: Text('Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Type'),
                                        ),
                                        DataColumn(
                                          label: Text('Date'),
                                        ),
                                        DataColumn(
                                          label: Text('From'),
                                        ),
                                        DataColumn(
                                          label: Text('To'),
                                        ),
                                        DataColumn(
                                          label: Text('Distance'),
                                        ),
                                        DataColumn(
                                          label: Text('Amount'),
                                        ),
                                        DataColumn(
                                          label: Text('Comment'),
                                        ),
                                        DataColumn(
                                          label: Text(' '),
                                        ),
                                      ],
                                      rows: provider.expenseList
                                          .where((category) => category.catId == 4)
                                          .map(
                                            (e) => DataRow(cells: [
                                              DataCell(Text(e.expenseName)),
                                              DataCell(Text(e.expenseTypeName)),
                                              DataCell(Text(e.fromDt)),
                                              DataCell(Text(e.fromPlace)),
                                              DataCell(Text(e.toPlace)),
                                              DataCell(Text('${e.mileage}')),
                                              DataCell(Text('${e.amount}')),
                                              DataCell(Text(e.comments)),
                                              DataCell(
                                                Row(
                                                  children: [
                                                    TableIconTap(
                                                      onTap: () async {
                                                        showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext context) => UpdateFuelExpenseScreen(
                                                              getExpenseProvider: getExpenseProvider,
                                                              id: widget.id,
                                                              expenseListIndex: index,
                                                              expenseListId: e.id),
                                                        );
                                                        provider.clear();
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
                                                                final response = await deleteExpenseListId({'Id': '${e.id}'});
                                                                if (response.statusCode == 200) {
                                                                  Navigator.pop(context);
                                                                  showDialog(
                                                                      barrierDismissible: false,
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return buildSingleButtonPopupDialog(
                                                                            icon: Icons.check_circle_outline_rounded,
                                                                            mainText: "Deleted!",
                                                                            text: "Your Travel Successfully Deleted.",
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                              provider.clear();
                                                                              provider.getExpenseData(context, widget.id);
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
                                            ]),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  sizeBox10h
                                ],
                              )
                            else if (provider.expenseList[index].catId == 5)
                              Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        provider.expenseTypeList[index].catName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      columns: const <DataColumn>[
                                        DataColumn(
                                          label: Text('Expense Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Type'),
                                        ),
                                        DataColumn(
                                          label: Text('Month'),
                                        ),
                                        DataColumn(
                                          label: Text('Amount'),
                                        ),
                                        DataColumn(
                                          label: Text('Comment'),
                                        ),
                                        DataColumn(
                                          label: Text(' '),
                                        ),
                                      ],
                                      rows: provider.expenseList
                                          .where((category) => category.catId == 5)
                                          .map(
                                            (e) => DataRow(cells: [
                                              DataCell(Text(e.expenseName)),
                                              DataCell(Text(e.expenseTypeName)),
                                              DataCell(Text(e.fromDt)),
                                              DataCell(Text('${e.amount}')),
                                              DataCell(Text(e.comments)),
                                              DataCell(
                                                Row(
                                                  children: [
                                                    TableIconTap(
                                                      onTap: () async {
                                                        showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext context) => UpdateMobileDataExpenseScreen(
                                                              getExpenseProvider: getExpenseProvider,
                                                              id: widget.id,
                                                              expenseListIndex: index,
                                                              expenseListId: e.id),
                                                        );
                                                        provider.clear();
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
                                                                final response = await deleteExpenseListId({'Id': '${e.id}'});
                                                                if (response.statusCode == 200) {
                                                                  Navigator.pop(context);
                                                                  showDialog(
                                                                      barrierDismissible: false,
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return buildSingleButtonPopupDialog(
                                                                            icon: Icons.check_circle_outline_rounded,
                                                                            mainText: "Deleted!",
                                                                            text: "Your Travel Successfully Deleted.",
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                              provider.clear();
                                                                              provider.getExpenseData(context, widget.id);
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
                                            ]),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ],
                              )
                            else if (provider.expenseList[index].catId == 6)
                              Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        provider.expenseTypeList[index].catName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      columns: const <DataColumn>[
                                        DataColumn(
                                          label: Text('Name'),
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
                                          label: Text('Amount'),
                                        ),
                                        DataColumn(
                                          label: Text('Comment'),
                                        ),
                                        DataColumn(
                                          label: Text(' '),
                                        ),
                                      ],
                                      rows: provider.expenseList
                                          .where((category) => category.catId == 6)
                                          .map(
                                            (e) => DataRow(cells: [
                                              DataCell(Text(e.expenseName)),
                                              DataCell(Text(e.expenseTypeName)),
                                              DataCell(Text(e.fromDt)),
                                              DataCell(Text(e.toDt)),
                                              DataCell(Text('${e.amount}')),
                                              DataCell(Text(e.comments)),
                                              DataCell(
                                                Row(
                                                  children: [
                                                    TableIconTap(
                                                      onTap: () async {
                                                        showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext context) => UpdateHotelStayExpenseScreen(
                                                              getExpenseProvider: getExpenseProvider,
                                                              id: widget.id,
                                                              expenseListIndex: index,
                                                              expenseListId: e.id),
                                                        );
                                                        provider.clear();
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
                                                                final response = await deleteExpenseListId({'Id': '${e.id}'});
                                                                if (response.statusCode == 200) {
                                                                  Navigator.pop(context);
                                                                  showDialog(
                                                                      barrierDismissible: false,
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return buildSingleButtonPopupDialog(
                                                                            icon: Icons.check_circle_outline_rounded,
                                                                            mainText: "Deleted!",
                                                                            text: "Your Travel Successfully Deleted.",
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                              provider.clear();
                                                                              provider.getExpenseData(context, widget.id);
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
                                            ]),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  sizeBox10h
                                ],
                              )
                            else
                              const SizedBox()
                          ],
                        );
                      }),
                sizeBox20h,
                if (!provider.loading)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Balance to be paid : ${int.parse(provider.totalAmount.toString().split(".")[0])}",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                sizeBox30h,
                if (!provider.loading)
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.r),
                      color: Colors.green,
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'APPLY',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
