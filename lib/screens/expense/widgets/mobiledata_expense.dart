import 'dart:developer';

import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/expense_data_provider.dart';
import 'package:archerhr_mobile/provider/expense_list_data_provider.dart';
import 'package:archerhr_mobile/provider/get_expense_provider.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

class MobileDataExpenseScreen extends StatefulWidget {
  MobileDataExpenseScreen({Key key, this.id,this.expenseDataProvider, this.expenseListDataProvider}) : super(key: key);
  ExpenseDataProvider expenseDataProvider;
  ExpenseListDataProvider expenseListDataProvider;
  int id;

  @override
  _MobileDataExpenseScreenState createState() => _MobileDataExpenseScreenState();
}

class _MobileDataExpenseScreenState extends State<MobileDataExpenseScreen> {
  int categoryDropdownValue;
  bool isLoading = false;

  DateTime selectedDate;
  ExpenseDataProvider expenseDataProvider;
  ExpenseListDataProvider expenseListDataProvider;
  GetExpenseProvider getExpenseProvider;
  TextEditingController monthController = TextEditingController();
  TextEditingController providerNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  monthTap(BuildContext context) async {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1, 12),
      initialDate: selectedDate ?? DateTime.now(),
    ).then((date) {
      if (date != null) {
        setState(() {
          selectedDate = date;
          if (selectedDate.month == 1) {
            monthController.text = "Jan";
          } else if (selectedDate.month == 2) {
            monthController.text = "Feb";
          } else if (selectedDate.month == 3) {
            monthController.text = "Mar";
          } else if (selectedDate.month == 4) {
            monthController.text = "Apr";
          } else if (selectedDate.month == 5) {
            monthController.text = "May";
          } else if (selectedDate.month == 6) {
            monthController.text = "Jun";
          } else if (selectedDate.month == 7) {
            monthController.text = "Jul";
          } else if (selectedDate.month == 8) {
            monthController.text = "Aug";
          } else if (selectedDate.month == 9) {
            monthController.text = "Sep";
          } else if (selectedDate.month == 10) {
            monthController.text = "Oct";
          } else if (selectedDate.month == 11) {
            monthController.text = "Nov";
          } else {
            monthController.text = "Dec";
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    expenseDataProvider = widget.expenseDataProvider;
    expenseListDataProvider = widget.expenseListDataProvider;
    getExpenseProvider = Provider.of<GetExpenseProvider>(context, listen: false);
    getExpenseProvider.clear();
    getExpenseProvider.getExpenseData(context, widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    expenseDataProvider.clear();
    expenseListDataProvider.clear();
    getExpenseProvider.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Category :",
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        child: DropdownButton<int>(
                          isExpanded: true,
                          icon: const SizedBox(),
                          hint: const Text("Choose Category"),
                          value: categoryDropdownValue,
                          underline: const SizedBox(),
                          items: expenseDataProvider.expenseType.where((category) => category.catId == 5).map((categoryList) {
                            return DropdownMenuItem(
                              child: Text(categoryList.name),
                              value: categoryList.id,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              categoryDropdownValue = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                sizeBox10w,
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Provider Name :",
                      ),
                      Input(
                        controller: providerNameController,
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
                      const TitleText(
                        label: "Month :",
                      ),
                      Input(
                        controller: monthController,
                        readOnly: true,
                        onTap: () => monthTap(context),
                      ),
                    ],
                  ),
                ),
                sizeBox10w,
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Amount :",
                      ),
                      Input(
                        controller: amountController,
                        keyboardType: TextInputType.number,
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
                      const TitleText(
                        label: "Comments :",
                      ),
                      Input(
                        controller: commentController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizeBox30h,
            Container(
              width: 150.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
                color: Palette.buttonBackgroundColor,
              ),
              child: TextButton(
                onPressed: _saveExpense,
                child: isLoading == false
                    ? Text(
                  'ADD',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                )
                    : const CircularProgressIndicator(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveExpense() async {
    if (categoryDropdownValue != null &&
        amountController.text.isNotEmpty &&
        providerNameController.text.isNotEmpty &&
        monthController.text.isNotEmpty &&
        commentController.text.isNotEmpty) {
      Utils.unFocus(context);
      isLoading = true;

      String month = DateFormat('MM-dd-yyyy').format(DateTime.parse(selectedDate.toString()));
      final expenseJson = {
        "TypeId": categoryDropdownValue,
        "ExpenseName": providerNameController.text,
        "FromDate": month,
        "Amount": amountController.text,
        "Comments": commentController.text,
      };

      if(widget.id != null){
        expenseJson.addAll({"ExpenseId" : widget.id});
      }

      final response = await saveExpense(body: expenseJson);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return buildSingleButtonPopupDialog(
                  context: context,
                  icon: Icons.check_circle_outline_rounded,
                  mainText: "Saved!",
                  text: "Expense Successfully Saved.",
                  onPressed: () {
                    Navigator.pop(context);
                    getExpenseProvider.clear();
                    expenseListDataProvider.clear();
                    expenseDataProvider.clear();
                    getExpenseProvider.getExpenseData(context, widget.id);
                    expenseListDataProvider.getEmpExpenseData(context);
                  });
            });
      } else if (response.statusCode == 404) {
        Navigator.pop(context);
        unAuthenticationDialog(context);
      } else {
        log(response.reasonPhrase);
      }
      isLoading = false;
    } else {
      Utils.showToast("Please enter detail");
    }
  }

}
