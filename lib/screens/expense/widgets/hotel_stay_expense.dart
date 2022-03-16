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
import 'package:provider/provider.dart';

class HotelStayExpenseScreen extends StatefulWidget {
  HotelStayExpenseScreen({Key key, this.id,this.expenseDataProvider, this.expenseListDataProvider}) : super(key: key);
  ExpenseDataProvider expenseDataProvider;
  ExpenseListDataProvider expenseListDataProvider;
  int id;

  @override
  _HotelStayExpenseScreenState createState() => _HotelStayExpenseScreenState();
}

class _HotelStayExpenseScreenState extends State<HotelStayExpenseScreen> {
  int categoryDropdownValue;
  bool isLoading = false;

  ExpenseDataProvider expenseDataProvider;
  ExpenseListDataProvider expenseListDataProvider;
  GetExpenseProvider getExpenseProvider;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController noOfDaysController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  dateTap(BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('MM-dd-yyyy').format(picked);
      if (fromDateController.text.isNotEmpty && toDateController.text.isNotEmpty) {
        noOfDaysController.text = DateFormat("MM-dd-yyyy")
            .parse(toDateController.text)
            .difference(DateFormat("MM-dd-yyyy").parse(fromDateController.text))
            .inDays
            .toString();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    expenseDataProvider = widget.expenseDataProvider;
    expenseListDataProvider = widget.expenseListDataProvider;
    getExpenseProvider = Provider.of<GetExpenseProvider>(context, listen: false);
    getExpenseProvider.clear();
    getExpenseProvider.getExpenseData(context, widget.id);
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
                          items: expenseDataProvider.expenseType.where((category) => category.catId == 6).map((categoryList) {
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
                        label: "Name :",
                      ),
                      Input(
                        controller: nameController,
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
                        label: "From Date :",
                      ),
                      Input(
                        controller: fromDateController,
                        readOnly: true,
                        onTap: () => dateTap(context, fromDateController),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "To Date :",
                      ),
                      Input(
                        controller: toDateController,
                        readOnly: true,
                        onTap: () => dateTap(context, toDateController),
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
                        label: "No of Days :",
                      ),
                      Input(
                        controller: noOfDaysController,
                        readOnly: true,
                        keyboardType: TextInputType.number,
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
        nameController.text.isNotEmpty &&
        fromDateController.text.isNotEmpty &&
        toDateController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        commentController.text.isNotEmpty) {
      Utils.unFocus(context);
      isLoading = true;

      final expenseJson = {
        "TypeId": categoryDropdownValue,
        "ExpenseName": nameController.text,
        "FromDate": fromDateController.text,
        "ToDate": toDateController.text,
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
                    getExpenseProvider.getExpenseData(context, widget.id);
                    expenseListDataProvider.clear();
                    expenseDataProvider.clear();
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
