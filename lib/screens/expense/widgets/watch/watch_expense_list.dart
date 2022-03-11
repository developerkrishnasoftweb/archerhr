import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/get_expense_provider.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WatchExpenseList extends StatefulWidget {
  WatchExpenseList({Key key, this.id}) : super(key: key);
  int id;

  @override
  _WatchExpenseListState createState() => _WatchExpenseListState();
}

class _WatchExpenseListState extends State<WatchExpenseList> {
  GetExpenseProvider getExpenseProvider;
  double total;

  @override
  void initState() {
    super.initState();
    getExpenseProvider = Provider.of<GetExpenseProvider>(context, listen: false);
    getExpenseProvider.getExpenseData(context, widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    getExpenseProvider.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetExpenseProvider>(
      builder: (context, provider, child) {
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
                                            label: Text('Comments'),
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
                                              ]),
                                            )
                                            .toList(),
                                      ),
                                    ),
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
                                              ]),
                                            )
                                            .toList(),
                                      ),
                                    ),
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
                                              ]),
                                            )
                                            .toList(),
                                      ),
                                    ),
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
                                            label: Text('Comments'),
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
                                              ]),
                                            )
                                            .toList(),
                                      ),
                                    ),
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
                      "STATUS : ${ provider.expense.status.name.toUpperCase()}",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  sizeBox20h,
                  if (!provider.loading)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "TOTAL : ${int.parse(provider.totalAmount.toString().split(".")[0])}",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
