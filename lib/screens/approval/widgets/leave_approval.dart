import 'dart:developer';

import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/get_leave_provider.dart';
import 'package:archerhr_mobile/provider/leave_approval_provider.dart';
import 'package:archerhr_mobile/provider/leave_data_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LeaveApprovalScreen extends StatefulWidget {
  LeaveApprovalScreen({Key key, this.id, this.leaveApprovalProvider}) : super(key: key);
  LeaveApprovalProvider leaveApprovalProvider;
  int id;

  @override
  _LeaveApprovalScreenState createState() => _LeaveApprovalScreenState();
}

class _LeaveApprovalScreenState extends State<LeaveApprovalScreen> {
  var statusList = ["Approve", "Reject"];
  String status;
  bool isLoading = false;
  LeaveDataProvider leaveDataProvider;
  GetLeaveProvider getLeaveProvider;
  LeaveApprovalProvider leaveApprovalProvider;

  TextEditingController categoryController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    leaveApprovalProvider = widget.leaveApprovalProvider;
    leaveDataProvider = Provider.of<LeaveDataProvider>(context, listen: false);
    getLeaveProvider = Provider.of<GetLeaveProvider>(context, listen: false);
    getLeaveInfo();
  }

  getLeaveInfo() async {
    await getLeaveProvider.getLeaveData(context, widget.id);

    String from = DateFormat('dd-MM-yyyy').format(DateTime.parse(getLeaveProvider.getLeave.from));
    String to = DateFormat('dd-MM-yyyy').format(DateTime.parse(getLeaveProvider.getLeave.to));

    categoryController.text = getLeaveProvider.getLeave.categoryName;
    typeController.text = getLeaveProvider.getLeave.type;
    fromDateController.text = from;
    toDateController.text = to;
    descriptionController.text = getLeaveProvider.getLeave.description;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    leaveDataProvider.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetLeaveProvider>(
      builder: (context, provider, child) {
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
                    "Leave Approval",
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
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(
                                        label: "Category",
                                      ),
                                      Input(
                                        controller: categoryController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
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
                                        label: "Type",
                                      ),
                                      Input(
                                        controller: typeController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
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
                                      const TitleText(
                                        label: "From Date",
                                      ),
                                      Input(
                                        controller: fromDateController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
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
                                        label: "To Date",
                                      ),
                                      Input(
                                        controller: toDateController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
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
                                      const TitleText(
                                        label: "Description",
                                      ),
                                      Input(
                                        controller: descriptionController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
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
                                      const TitleText(
                                        label: "Reason",
                                      ),
                                      Input(
                                        controller: reasonController,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizeBox30h,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(7.r),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      if (reasonController.text.isNotEmpty) {
                                        Navigator.pop(context);
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return buildDoubleButtonPopupDialog(
                                                  context: context,
                                                  icon: Icons.error_outline_rounded,
                                                  colorIcon: Colors.green,
                                                  mainText: "Are you sure ?",
                                                  text: "You want to Approve Leave !",
                                                  buttonName: "YES,APPROVE!",
                                                  colorButton: Colors.green,
                                                  onPressed: () async {
                                                    final statusJson = {
                                                      "Reason": reasonController.text,
                                                      "Id": widget.id,
                                                      "StatusId": 3
                                                    };

                                                    final response = await statusLeaveUpdate(body: statusJson);

                                                    if (response.statusCode == 200) {
                                                      Navigator.pop(context);
                                                      showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return buildSingleButtonPopupDialog(
                                                                context: context,
                                                                icon: Icons.check_circle_outline_rounded,
                                                                mainText: "Approved",
                                                                text: "Leave Successfully Approved.",
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                  leaveApprovalProvider.clear();
                                                                  leaveApprovalProvider.getLeaveApproval(context);
                                                                  leaveDataProvider.clear();
                                                                  leaveDataProvider.getEmpLeaveData(context);
                                                                });
                                                          });
                                                    } else if (response.statusCode == 404) {
                                                      Navigator.pop(context);
                                                      unAuthenticationDialog(context);
                                                    } else {
                                                      log(response.reasonPhrase);
                                                    }
                                                  });
                                            });
                                      } else {
                                        Utils.showToast("Please Enter Reason");
                                      }
                                    },
                                    child: Text(
                                      "APPROVE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                sizeBox10w,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(7.r),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      if (reasonController.text.isNotEmpty) {
                                        Navigator.pop(context);
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return buildDoubleButtonPopupDialog(
                                                  context: context,
                                                  icon: Icons.error_outline_rounded,
                                                  mainText: "Are you sure ?",
                                                  text: "You want to Reject Leave !",
                                                  buttonName: "YES,REJECTED!",
                                                  onPressed: () async {
                                                    final statusJson = {
                                                      "Reason": reasonController.text,
                                                      "Id": widget.id,
                                                      "StatusId": 4
                                                    };

                                                    final response = await statusLeaveUpdate(body: statusJson);

                                                    if (response.statusCode == 200) {
                                                      Navigator.pop(context);
                                                      showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return buildSingleButtonPopupDialog(
                                                                context: context,
                                                                icon: Icons.check_circle_outline_rounded,
                                                                mainText: "Rejected",
                                                                text: "Leave Successfully Rejected.",
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                  leaveApprovalProvider.clear();
                                                                  leaveApprovalProvider.getLeaveApproval(context);
                                                                  leaveDataProvider.clear();
                                                                  leaveDataProvider.getEmpLeaveData(context);
                                                                });
                                                          });
                                                    } else if (response.statusCode == 404) {
                                                      Navigator.pop(context);
                                                      unAuthenticationDialog(context);
                                                    } else {
                                                      log(response.reasonPhrase);
                                                    }
                                                  });
                                            });
                                      } else {
                                        Utils.showToast("Please Enter Reason");
                                      }
                                    },
                                    child: Text(
                                      "REJECT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }

/*  _statusApproveLeave() async {
    Utils.unFocus(context);
    isLoading = true;

    final statusJson = {"Reason": reasonController.text, "Id": widget.id, "StatusId": 3};

    final response = await statusLeaveUpdate(body: statusJson);

    if (response.statusCode == 200) {
      Navigator.pop(context);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return buildSingleButtonPopupDialog(
                context: context,
                icon: Icons.check_circle_outline_rounded,
                mainText: "Approved",
                text: "Leave Successfully Approved.",
                onPressed: () {
                  Navigator.pop(context);
                  leaveApprovalProvider.clear();
                  leaveApprovalProvider.getLeaveApproval(context);
                  leaveDataProvider.clear();
                  leaveDataProvider.getEmpLeaveData(context);
                });
          });
    } else if (response.statusCode == 404) {
      Navigator.pop(context);
      unAuthenticationDialog(context);
    } else {
      log(response.reasonPhrase);
    }
    isLoading = false;
  }
  _statusRejectLeave() async {
    Utils.unFocus(context);
    isLoading = true;

    final statusJson = {"Reason": reasonController.text, "Id": widget.id, "StatusId": 4};

    final response = await statusLeaveUpdate(body: statusJson);

    if (response.statusCode == 200) {
      Navigator.pop(context);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return buildSingleButtonPopupDialog(
                context: context,
                icon: Icons.check_circle_outline_rounded,
                mainText: "Rejected",
                text: "Leave Successfully Rejected.",
                onPressed: () {
                  Navigator.pop(context);
                  leaveApprovalProvider.clear();
                  leaveApprovalProvider.getLeaveApproval(context);
                  leaveDataProvider.clear();
                  leaveDataProvider.getEmpLeaveData(context);
                });
          });
    } else if (response.statusCode == 404) {
      Navigator.pop(context);
      unAuthenticationDialog(context);
    } else {
      log(response.reasonPhrase);
    }
    isLoading = false;
  }*/
}
