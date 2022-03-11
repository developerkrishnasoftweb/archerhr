import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/leave_data_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class FullDayLeaveScreen extends StatefulWidget {
  FullDayLeaveScreen({Key key, this.leaveDataProvider}) : super(key: key);

  LeaveDataProvider leaveDataProvider;

  @override
  _FullDayLeaveScreenState createState() => _FullDayLeaveScreenState();
}

class _FullDayLeaveScreenState extends State<FullDayLeaveScreen> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;
  String leaveTypeDropdownValue;
  LeaveDataProvider leaveDataProvider;

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
    leaveDataProvider = widget.leaveDataProvider;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        fromDateController.clear();
        toDateController.clear();
        descriptionController.clear();
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
                  "Apply full day",
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
                              const TitleText(label: "Leave Type"),
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
                              const TitleText(label: "From Date"),
                              Input(
                                controller: fromDateController,
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
                    const TitleText(label: "Description"),
                    Input(
                      controller: descriptionController,
                    ),
                  ],
                ),
              ),
            ],
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
        descriptionController.text.isNotEmpty) {
      // unFocus keyboard
      Utils.unFocus(context);

      isLoading = true;

      final leaveJson = {
        "LeaveCategoryId": 1,
        "From": fromDateController.text,
        "To": toDateController.text,
        "LeaveTypeId": leaveTypeDropdownValue,
        "Description": descriptionController.text,
      };

      final response = await saveFullLeave(leaveJson);
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
      } else {
        // print(response.reasonPhrase);
      }
      isLoading = false;
    } else {
      Utils.showToast("Please enter detail");
    }
  }
}
