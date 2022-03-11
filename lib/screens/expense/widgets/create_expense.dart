import 'package:archerhr_mobile/provider/expense_data_provider.dart';
import 'package:archerhr_mobile/provider/expense_list_data_provider.dart';
import 'package:archerhr_mobile/provider/get_expense_provider.dart';
import 'package:archerhr_mobile/screens/expense/widgets/fixed_allowance_expense.dart';
import 'package:archerhr_mobile/screens/expense/widgets/fuel_expense.dart';
import 'package:archerhr_mobile/screens/expense/widgets/hotel_stay_expense.dart';
import 'package:archerhr_mobile/screens/expense/widgets/mobiledata_expense.dart';
import 'package:archerhr_mobile/screens/expense/widgets/other_expense.dart';
import 'package:archerhr_mobile/screens/expense/widgets/travel_expense.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CreateExpense extends StatefulWidget {
  CreateExpense({Key key, this.expenseListDataProvider, this.id, this.expenseDataProvider}) : super(key: key);
  ExpenseListDataProvider expenseListDataProvider;
  int id;
  ExpenseDataProvider expenseDataProvider;

  @override
  _CreateExpenseState createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  ExpenseDataProvider expenseDataProvider;
  ExpenseListDataProvider expenseListDataProvider;
  GetExpenseProvider getExpenseProvider;

  @override
  void initState() {
    super.initState();
    expenseDataProvider = widget.expenseDataProvider;
    expenseListDataProvider = widget.expenseListDataProvider;
    getExpenseProvider = Provider.of<GetExpenseProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetExpenseProvider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            /*Navigator.pop(context);*/
            getExpenseProvider.clear();
            getExpenseProvider.getExpenseData(context, widget.id);
            expenseListDataProvider.clear();
            expenseDataProvider.clear();
            expenseDataProvider.getEmpExpenseData(context);
            expenseListDataProvider.getEmpExpenseData(context);
            return true;
          },
          child: AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.r),
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
                      widget.id == null ? "Create Expense" : "Add Expense ${widget.id}",
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
                        getExpenseProvider.clear();
                        getExpenseProvider.getExpenseData(context, widget.id);
                        expenseListDataProvider.clear();
                        expenseDataProvider.clear();
                        expenseDataProvider.getEmpExpenseData(context);
                        expenseListDataProvider.getEmpExpenseData(context);
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
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: DefaultTabController(
                length: 6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Palette.expenseTabBar,
                      child: const TabBar(
                        labelColor: Colors.white,
                        isScrollable: true,
                        unselectedLabelColor: Colors.white,
                        indicator: BoxDecoration(
                          color: Palette.selectedExpenseTabBar,
                        ),
                        tabs: [
                          Tab(text: 'FIXED ALLOWANCE'),
                          Tab(text: 'TRAVEL EXPENSE'),
                          Tab(text: 'HOTEL/STAY'),
                          Tab(text: 'FUEL EXPENSE'),
                          Tab(text: 'MOBILE/DATA CARD'),
                          Tab(text: 'OTHER EXPENSE'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        FixedAllowanceScreen(
                            id: widget.id,
                            expenseDataProvider: expenseDataProvider,
                            expenseListDataProvider: expenseListDataProvider),
                        TravelExpenseScreen(
                            id: widget.id,
                            expenseDataProvider: expenseDataProvider,
                            expenseListDataProvider: expenseListDataProvider),
                        HotelStayExpenseScreen(
                            id: widget.id,
                            expenseDataProvider: expenseDataProvider,
                            expenseListDataProvider: expenseListDataProvider),
                        FuelExpenseScreen(
                            id: widget.id,
                            expenseDataProvider: expenseDataProvider,
                            expenseListDataProvider: expenseListDataProvider),
                        MobileDataExpenseScreen(
                            id: widget.id,
                            expenseDataProvider: expenseDataProvider,
                            expenseListDataProvider: expenseListDataProvider),
                        OtherExpenseScreen(
                            id: widget.id,
                            expenseDataProvider: expenseDataProvider,
                            expenseListDataProvider: expenseListDataProvider),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
