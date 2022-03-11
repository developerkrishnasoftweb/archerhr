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
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

class UpdateMobileDataExpenseScreen extends StatefulWidget {
  UpdateMobileDataExpenseScreen({Key key, this.expenseListIndex, this.id, this.getExpenseProvider, this.expenseListId})
      : super(key: key);
  GetExpenseProvider getExpenseProvider;
  int id;
  int expenseListIndex;
  int expenseListId;

  @override
  _UpdateMobileDataExpenseScreenState createState() => _UpdateMobileDataExpenseScreenState();
}

class _UpdateMobileDataExpenseScreenState extends State<UpdateMobileDataExpenseScreen> {
  int categoryDropdownValue;
  bool isLoading = false;

  DateTime selectedDate;
  ExpenseDataProvider expenseDataProvider;
  GetExpenseProvider getExpenseProvider;
  ExpenseListDataProvider expenseListDataProvider;
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
    expenseDataProvider = Provider.of<ExpenseDataProvider>(context, listen: false);
    expenseDataProvider.clear();
    expenseDataProvider.getEmpExpenseData(context);
    getExpenseProvider = Provider.of<GetExpenseProvider>(context, listen: false);
    //getExpenseProvider.clear();
    getExpenseById();
  }

  getExpenseById() async {
    await getExpenseProvider.getExpenseData(context, widget.id);
    selectedDate = DateTime.parse(DateFormat("yyyy-MM-dd")
        .format(DateFormat('dd-MM-yyyy').parse(getExpenseProvider.expenseList[widget.expenseListIndex].fromDt)));

    if (selectedDate.month == 01) {
      monthController.text = "Jan";
    } else if (selectedDate.month == 02) {
      monthController.text = "Feb";
    } else if (selectedDate.month == 03) {
      monthController.text = "Mar";
    } else if (selectedDate.month == 04) {
      monthController.text = "Apr";
    } else if (selectedDate.month == 05) {
      monthController.text = "May";
    } else if (selectedDate.month == 06) {
      monthController.text = "Jun";
    } else if (selectedDate.month == 07) {
      monthController.text = "Jul";
    } else if (selectedDate.month == 08) {
      monthController.text = "Aug";
    } else if (selectedDate.month == 09) {
      monthController.text = "Sep";
    } else if (selectedDate.month == 10) {
      monthController.text = "Oct";
    } else if (selectedDate.month == 11) {
      monthController.text = "Nov";
    } else {
      monthController.text = "Dec";
    }

    //categoryDropdownValue = getExpenseProvider.expenseList[widget.expenseListIndex].catId;
    providerNameController.text = getExpenseProvider.expenseList[widget.expenseListIndex].expenseName;
    amountController.text =
        '${int.parse(getExpenseProvider.expenseList[widget.expenseListIndex].amount.toString().split(".")[0])}';
    commentController.text = getExpenseProvider.expenseList[widget.expenseListIndex].comments;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetExpenseProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: () async{
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
                    "Edit Mobile/Data",
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
                                            .where((category) => category.catId == 5)
                                            .map((categoryList) {
                                          return DropdownMenuItem<int>(
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
                              onPressed: _updateExpense,
                              child: isLoading == false
                                  ? Text(
                                      'UPDATE',
                                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                    )
                                  : const CircularProgressIndicator(color: Colors.white),
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
    });
  }

  _updateExpense() async {
    if (categoryDropdownValue != null &&
        amountController.text.isNotEmpty &&
        providerNameController.text.isNotEmpty &&
        monthController.text.isNotEmpty &&
        commentController.text.isNotEmpty) {
      Utils.unFocus(context);
      isLoading = true;

      String month = DateFormat('MM-dd-yyyy').format(DateTime.parse(selectedDate.toString()));
      final expenseJson = {
        "ExpenseId": widget.id,
        "Id": widget.expenseListId,
        "TypeId": categoryDropdownValue,
        "ExpenseName": providerNameController.text,
        "FromDate": month,
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
