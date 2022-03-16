import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/model/expense_list_data_model.dart';
import 'package:archerhr_mobile/provider/expense_data_provider.dart';
import 'package:archerhr_mobile/provider/expense_list_data_provider.dart';
import 'package:archerhr_mobile/screens/expense/widgets/create_expense.dart';
import 'package:archerhr_mobile/screens/expense/widgets/update/update_expense_list.dart';
import 'package:archerhr_mobile/screens/expense/widgets/watch/watch_expense_list.dart';
import 'package:archerhr_mobile/screens/widgets/table_icon_tap.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key key}) : super(key: key);

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  ExpenseListDataProvider expenseListDataProvider;
  ExpenseDataProvider expenseDataProvider;

  @override
  void initState() {
    super.initState();
    expenseListDataProvider = Provider.of<ExpenseListDataProvider>(context, listen: false);
    expenseListDataProvider.clear();
    expenseListDataProvider.getEmpExpenseData(context);
    expenseDataProvider = Provider.of<ExpenseDataProvider>(context, listen: false);
    expenseDataProvider.getEmpExpenseData(context);
  }

  @override
  void dispose() {
    super.dispose();
    expenseListDataProvider.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.appBackground,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                      child: Consumer<ExpenseListDataProvider>(
                        builder: (context, provider, child) {
                          if (provider.loading) {
                            return const CircularProgressIndicator(
                              color: Palette.circularProgress,
                            );
                          }
                          if (provider.expenseList.isNotEmpty) {
                            return PaginatedDataTable(
                              source: ExpenseSource(expenseList: provider.expenseList,context: context,expenseDataProvider: expenseDataProvider,expenseListDataProvider: provider),
                              rowsPerPage: provider.expenseList.length > 10 ? 10 : provider.expenseList.length,
                              showFirstLastButtons: true,
                              headingRowHeight: 40,
                              columnSpacing: 30,
                              horizontalMargin: 30,
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Text(''),
                                ),
                                DataColumn(
                                  label: Text('Status'),
                                ),
                                DataColumn(
                                  label: Text('Id'),
                                ),
                                DataColumn(
                                  label: Text('Date'),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                CreateExpense(expenseListDataProvider: expenseListDataProvider, expenseDataProvider: expenseDataProvider),
          );
        },
      ),
    );
  }
}

class ExpenseSource extends DataTableSource {
  List<MyExpenseList> expenseList;
  BuildContext context;
  ExpenseListDataProvider expenseListDataProvider;
  ExpenseDataProvider expenseDataProvider;

  ExpenseSource({this.expenseList,this.context,this.expenseDataProvider,this.expenseListDataProvider});

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        expenseList[index].statusId == 3 || expenseList[index].statusId == 4
            ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TableIconTap(
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => WatchExpenseList(id: expenseList[index].id),
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
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => UpdateExpenseList(
                    id: expenseList[index].id, expenseListDataProvider: expenseListDataProvider,expenseDataProvider: expenseDataProvider,),
                );
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
                        final response = await deleteExpenseId({'Id': '${expenseList[index].id}'});
                        if (response.statusCode == 200) {
                          Navigator.pop(context);
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return buildSingleButtonPopupDialog(
                                    icon: Icons.check_circle_outline_rounded,
                                    mainText: "Deleted!",
                                    text: "Your Expense Successfully Deleted.",
                                    onPressed: () {
                                      Navigator.pop(context);
                                      expenseListDataProvider.clear();
                                      expenseListDataProvider.getEmpExpenseData(context);
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
              icon: Icons.delete_rounded,
              color: Colors.red,
            ),
          ],
        ),
      ),
      DataCell(expenseList[index].statusId == 3
          ? approveStatus()
          : expenseList[index].statusId == 4
          ? rejectStatus()
          : expenseList[index].statusId == 2
          ? appliedStatus()
          : saveStatus()),
      DataCell(Text('${expenseList[index].id}')),
      DataCell(Text(expenseList[index].appliedDate)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => expenseList.length;

  @override
  int get selectedRowCount => 0;

}