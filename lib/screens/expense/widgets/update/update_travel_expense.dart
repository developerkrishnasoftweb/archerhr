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

class UpdateTravelExpenseScreen extends StatefulWidget {
  UpdateTravelExpenseScreen({Key key, this.getExpenseProvider, this.id, this.expenseListIndex, this.expenseListId,this.expenseDataProvider})
      : super(key: key);
  GetExpenseProvider getExpenseProvider;
  int id;
  int expenseListIndex;
  int expenseListId;
  ExpenseDataProvider expenseDataProvider;

  @override
  _UpdateTravelExpenseScreenState createState() => _UpdateTravelExpenseScreenState();
}

class _UpdateTravelExpenseScreenState extends State<UpdateTravelExpenseScreen> {
  int categoryDropdownValue;
  bool isLoading = false;

  ExpenseDataProvider expenseDataProvider;
  GetExpenseProvider getExpenseProvider;
  ExpenseListDataProvider expenseListDataProvider;
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
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
      String formattedDate = DateFormat('MM-dd-yyyy').format(picked);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    expenseDataProvider = widget.expenseDataProvider;
    getExpenseProvider = Provider.of<GetExpenseProvider>(context, listen: false);
    getExpenseById();
  }

  @override
  void dispose() {
    super.dispose();
    expenseDataProvider.clear();
    //getExpenseProvider.clear();
  }

  getExpenseById() async {
    await getExpenseProvider.getExpenseData(context, widget.id);
    String date = DateFormat("MM-dd-yyyy")
        .format(DateFormat('dd-MM-yyyy').parse(getExpenseProvider.expenseList[widget.expenseListIndex].fromDt));

   // categoryDropdownValue = getExpenseProvider.expenseList[widget.expenseListIndex].catId;
    dateController.text = date;
    nameController.text = getExpenseProvider.expenseList[widget.expenseListIndex].expenseName;
    fromController.text = getExpenseProvider.expenseList[widget.expenseListIndex].fromPlace;
    toController.text = getExpenseProvider.expenseList[widget.expenseListIndex].toPlace;
    amountController.text =
        '${int.parse(getExpenseProvider.expenseList[widget.expenseListIndex].amount.toString().split(".")[0])}';
    commentController.text = getExpenseProvider.expenseList[widget.expenseListIndex].comments;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetExpenseProvider>(builder: (context, provider, child) {
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
                    "Edit Travel",
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
                                            .where((category) => category.catId == 2)
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
                                      label: "Date :",
                                    ),
                                    Input(
                                      controller: dateController,
                                      readOnly: true,
                                      onTap: () => dateTap(context, dateController),
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
                                      label: "From :",
                                    ),
                                    Input(
                                      controller: fromController,
                                    ),
                                  ],
                                ),
                              ),
                              sizeBox10w,
                              Expanded(
                                child: Column(
                                  children: [
                                    const TitleText(
                                      label: "To :",
                                    ),
                                    Input(
                                      controller: toController,
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
    });
  }

  _updateExpense() async {
    if (categoryDropdownValue != null &&
        nameController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        fromController.text.isNotEmpty &&
        toController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        commentController.text.isNotEmpty) {
      Utils.unFocus(context);
      isLoading = true;

      final expenseJson = {
        "ExpenseId": widget.id,
        "Id": widget.expenseListId,
        "TypeId": categoryDropdownValue,
        "ExpenseName": nameController.text,
        "FromDate": dateController.text,
        "FromPlace": fromController.text,
        "ToPlace": toController.text,
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
