import 'dart:developer';

import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/expense_data_provider.dart';
import 'package:archerhr_mobile/provider/expense_list_data_provider.dart';
import 'package:archerhr_mobile/provider/get_expense_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateFixedAllowanceScreen extends StatefulWidget {
  UpdateFixedAllowanceScreen({Key key, this.expenseListIndex, this.id, this.getExpenseProvider, this.expenseListId,this.expenseDataProvider})
      : super(key: key);
  GetExpenseProvider getExpenseProvider;
  int id;
  int expenseListIndex;
  int expenseListId;
  ExpenseDataProvider expenseDataProvider;

  @override
  _UpdateFixedAllowanceScreenState createState() => _UpdateFixedAllowanceScreenState();
}

class _UpdateFixedAllowanceScreenState extends State<UpdateFixedAllowanceScreen> {
  int categoryDropdownValue;
  bool isLoading = false;

  ExpenseDataProvider expenseDataProvider;
  ExpenseListDataProvider expenseListDataProvider;
  GetExpenseProvider getExpenseProvider;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController perDayController = TextEditingController();
  TextEditingController noOfDaysController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController fileController = TextEditingController();

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
    getExpenseProvider = Provider.of<GetExpenseProvider>(context, listen: false);
    getExpenseById();
  }

  getExpenseById() async {
    await getExpenseProvider.getExpenseData(context, widget.id);

    String fromDate = DateFormat("MM-dd-yyyy")
        .format(DateFormat('dd-MM-yyyy').parse(getExpenseProvider.expenseList[widget.expenseListIndex].fromDt));
    String toDate = DateFormat("MM-dd-yyyy")
        .format(DateFormat('dd-MM-yyyy').parse(getExpenseProvider.expenseList[widget.expenseListIndex].toDt));

    categoryDropdownValue = getExpenseProvider.expenseList[widget.expenseListIndex].catId;
    fromDateController.text = fromDate;
    toDateController.text = toDate;
    nameController.text = getExpenseProvider.expenseList[widget.expenseListIndex].expenseName;
    amountController.text =
        '${int.parse(getExpenseProvider.expenseList[widget.expenseListIndex].amount.toString().split(".")[0])}';
    perDayController.text = '${int.parse(getExpenseProvider.expenseList[widget.expenseListIndex].rate.toString().split(".")[0])}';
    noOfDaysController.text =
        '${int.parse((getExpenseProvider.expenseList[widget.expenseListIndex].amount / getExpenseProvider.expenseList[widget.expenseListIndex].rate).toString().split(".")[0])}';
    commentController.text = getExpenseProvider.expenseList[widget.expenseListIndex].comments;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    expenseDataProvider.clear();
    //getExpenseProvider.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetExpenseProvider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            expenseDataProvider.clear();
            expenseDataProvider.getEmpExpenseData(context);
            getExpenseProvider.clear();
            getExpenseProvider.getExpenseData(context, widget.id);
            return true;
          },
          child: AlertDialog(
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
                      "Edit Fixed Allowance",
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
                        expenseDataProvider.clear();
                        expenseDataProvider.getEmpExpenseData(context);
                        getExpenseProvider.clear();
                        getExpenseProvider.getExpenseData(context, widget.id);
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
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 0.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (provider.loading)
                        const CircularProgressIndicator()
                      else
                        Column(
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
                                          items: expenseDataProvider.expenseType
                                              .where((category) => category.catId == 1)
                                              .map((categoryList) {
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
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          amountController.text =
                                              ((int.tryParse(value) ?? 0) * (int.tryParse(perDayController.text) ?? 0))
                                                  .toString();
                                        },
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
                                        label: "Per Day :",
                                      ),
                                      Input(
                                        controller: perDayController,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          amountController.text =
                                              ((int.tryParse(noOfDaysController.text) ?? 0) * (int.tryParse(value) ?? 0))
                                                  .toString();
                                        },
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
                                        label: "Total Amount :",
                                      ),
                                      Input(
                                        controller: amountController,
                                        keyboardType: TextInputType.number,
                                        readOnly: true,
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
                            Center(
                              child: Container(
                                width: 150.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.r),
                                  color: Palette.buttonBackgroundColor,
                                ),
                                child: TextButton(
                                  onPressed: _updateExpense,
                                  child: isLoading == false
                                      ? Text(
                                          'UPDATE',
                                          style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                        )
                                      : const CircularProgressIndicator(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _updateExpense() async {
    if (categoryDropdownValue != null &&
        nameController.text.isNotEmpty &&
        fromDateController.text.isNotEmpty &&
        toDateController.text.isNotEmpty &&
        perDayController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        commentController.text.isNotEmpty) {
      Utils.unFocus(context);
      isLoading = true;

      final expenseJson = <String, dynamic>{
        "ExpenseId": widget.id,
        "Id": widget.expenseListId,
        "TypeId": categoryDropdownValue.toString(),
        "ExpenseName": nameController.text,
        "FromDate": fromDateController.text,
        "ToDate": toDateController.text,
        "Rate": perDayController.text,
        "Amount": amountController.text,
        "Comments": commentController.text,
      };

      final response = await updateExpenseList(body: expenseJson);

      if (response.statusCode == 200) {
        Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return buildSingleButtonPopupDialog(
                  context: context,
                  icon: Icons.check_circle_outline_rounded,
                  mainText: "Updated!",
                  text: "Claim Successfully Update.",
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
