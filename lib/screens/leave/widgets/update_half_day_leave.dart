import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/get_leave_provider.dart';
import 'package:archerhr_mobile/provider/leave_data_provider.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateHalfDay extends StatefulWidget {
  UpdateHalfDay({Key key, this.leaveDataProvider, this.id}) : super(key: key);
  LeaveDataProvider leaveDataProvider;
  int id;

  @override
  _UpdateHalfDayState createState() => _UpdateHalfDayState();
}

class _UpdateHalfDayState extends State<UpdateHalfDay> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  LeaveDataProvider leaveDataProvider;
  GetLeaveProvider getLeaveProvider;

  String dropdownValue;
  int leaveTypeDropdownValue;

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
    getLeaveProvider = Provider.of<GetLeaveProvider>(context, listen: false);
    getLeaveById();
  }

  getLeaveById() async {
    await getLeaveProvider.getLeaveData(context,widget.id);

    String from = DateFormat('MM-dd-yyyy').format(DateTime.parse(getLeaveProvider.getLeave.from));
    String to = DateFormat('MM-dd-yyyy').format(DateTime.parse(getLeaveProvider.getLeave.to));

    leaveTypeDropdownValue = getLeaveProvider.getLeave.leaveTypeId;
    fromDateController.text = from;
    toDateController.text = to;
    descriptionController.text = getLeaveProvider.getLeave.description;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    getLeaveProvider.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetLeaveProvider>(builder: (context, provider, child) {
      return AlertDialog(
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
                  "Edit Half Day",
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
                    toDateController.clear();
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
                children: [
                  if (provider.loading)
                    const CircularProgressIndicator()
                  else
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
                                            value: type.leaveTypeId,
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
          if (!provider.loading)
            Padding(
              padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
              child: Container(
                width: 150.w,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: TextButton(
                  onPressed: _updateLeave,
                  child: isLoading == false
                      ? Text(
                          "UPDATE LEAVE",
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
      );
    });
  }

  _updateLeave() async {
    if (leaveTypeDropdownValue != null &&
        fromDateController.text.isNotEmpty &&
        toDateController.text.isNotEmpty &&
        dropdownValue.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      /// unFocus keyboard
      Utils.unFocus(context);

      isLoading = true;

      final leaveJson = {
        "Id": widget.id,
        "LeaveCategoryId": dropdownValue,
        "From": fromDateController.text,
        "To": toDateController.text,
        "LeaveTypeId": leaveTypeDropdownValue,
        "Description": descriptionController.text,
      };

      final response = await updateLeave(leaveJson);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return buildSingleButtonPopupDialog(
                  context: context,
                  icon: Icons.update_rounded,
                  mainText: "Updated",
                  text: "Leave Update Successfully.",
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
      Utils.showToast("Please enter detail");
    }
  }
}
