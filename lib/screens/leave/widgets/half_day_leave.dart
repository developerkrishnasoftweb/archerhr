import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/leave_data_provider.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HalfDayLeaveScreen extends StatefulWidget {
  HalfDayLeaveScreen({Key key,this.leaveDataProvider}) : super(key: key);

  LeaveDataProvider leaveDataProvider;

  @override
  _HalfDayLeaveScreenState createState() => _HalfDayLeaveScreenState();
}

class _HalfDayLeaveScreenState extends State<HalfDayLeaveScreen> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  LeaveDataProvider leaveDataProvider;

  String dropdownValue;
  String leaveTypeDropdownValue;

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
        controller.text = formattedDate; //set output date to TextField value.
      });
    }
  }

  @override
  void initState() {
    super.initState();
    leaveDataProvider = widget.leaveDataProvider;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
        titlePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
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
                  "Apply half day",
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
                    fromDateController.clear();
                    descriptionController.clear();
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
              padding: EdgeInsets.only(bottom: 5.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    child: Text(
                                      "Leave Type",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      icon: const Visibility(
                                        visible: false,
                                        child: Icon(Icons.arrow_drop_down_outlined),
                                      ),
                                      hint: const Text("Choose Leave Type"),
                                      underline: const SizedBox(),
                                      items: leaveDataProvider.leaveTypeList.map((type) {
                                        return DropdownMenuItem(
                                          child: Text(type.name),
                                          value: type.leaveTypeId.toString(),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          leaveTypeDropdownValue = newValue;
                                        });
                                      },
                                      value: leaveTypeDropdownValue,
                                    ),
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
                                  Align(
                                    child: Text(
                                      "From Date",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                  TextFormField(
                                    controller: fromDateController,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    readOnly: true,
                                    onTap: () => dateTap(context, fromDateController),
                                  ),
                                ],
                              ),
                            ),
                            sizeBox10w,
                            Expanded(
                              child: Column(
                                children: [
                                  const TitleText(label: "To Date"),
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
                        Align(
                          child: Text(
                            "Leave Category",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            icon: const Visibility(
                              visible: false,
                              child: Icon(Icons.arrow_drop_down_outlined),
                            ),
                            underline: const SizedBox(),
                            hint: const Text("Choose Leave Type"),
                            items: leaveDataProvider.leaveCategoryList.map((category) {
                              return DropdownMenuItem(
                                child: Text(category.name),
                                value: category.id.toString(),
                              );
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            value: dropdownValue,
                          ),
                        ),
                        sizeBox20h,
                        Align(
                          child: Text(
                            "Description",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        TextFormField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
            child: Container(
              width: 150.w,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: TextButton(
                onPressed: _saveLeave,
                child: isLoading == false
                    ? Text(
                        "APPLY LEAVE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      )
                    : const CircularProgressIndicator(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _saveLeave() async {
    if (leaveTypeDropdownValue.isNotEmpty &&
        fromDateController.text.isNotEmpty &&
        toDateController.text.isNotEmpty &&
        dropdownValue.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      // unFocus keyboard
      Utils.unFocus(context);

      isLoading = true;

      final leaveJson = {
        "LeaveCategoryId": dropdownValue,
        "From": fromDateController.text,
        "To": toDateController.text,
        "LeaveTypeId": leaveTypeDropdownValue,
        "Description": descriptionController.text,
      };

      final response = await saveFullLeave(leaveJson);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return buildSingleButtonPopupDialog(
                  context: context,
                  icon: Icons.check_circle_outline_rounded,
                  mainText: "Applied",
                  text: "Leave Successfully Applied.",
                  onPressed: () {
                    Navigator.pop(context);
                    leaveDataProvider.empList.clear();
                    leaveDataProvider.leaveAvailList.clear();
                    leaveDataProvider.leaveTypeList.clear();
                    leaveDataProvider.leaveCategoryList.clear();
                    leaveDataProvider.getEmpLeaveData(context);
                  });
            });
      } else if (response.statusCode == 404) {
        Navigator.pop(context);
        unAuthenticationDialog(context);
      }
      isLoading = false;
    } else {
      Utils.showToast("Please enter Detail");
    }
  }
}
