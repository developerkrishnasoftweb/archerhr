import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/get_leave_provider.dart';
import 'package:archerhr_mobile/provider/leave_data_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WatchLeaveScreen extends StatefulWidget {
  WatchLeaveScreen({Key key, this.id, this.leaveDataProvider}) : super(key: key);
  LeaveDataProvider leaveDataProvider;
  int id;

  @override
  _WatchLeaveScreenState createState() => _WatchLeaveScreenState();
}

class _WatchLeaveScreenState extends State<WatchLeaveScreen> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  bool isLoading = false;
  int leaveTypeDropdownValue;
  LeaveDataProvider leaveDataProvider;
  GetLeaveProvider getLeaveProvider;

  @override
  void initState() {
    super.initState();
    leaveDataProvider = widget.leaveDataProvider;
    getLeaveProvider = Provider.of<GetLeaveProvider>(context, listen: false);
    getLeaveById();
  }

  getLeaveById() async {
    await getLeaveProvider.getLeaveData(context, widget.id);

    String from = DateFormat('dd-MM-yyyy').format(DateTime.parse(getLeaveProvider.getLeave.from));
    String to = DateFormat('dd-MM-yyyy').format(DateTime.parse(getLeaveProvider.getLeave.to));

    leaveTypeDropdownValue = getLeaveProvider.getLeave.leaveTypeId;
    fromDateController.text = from;
    toDateController.text = to;
    descriptionController.text = getLeaveProvider.getLeave.description;
    categoryController.text = getLeaveProvider.getLeave.categoryName;
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
                  "Leave Details",
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
                                    const TitleText(label: "Category"),
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
                                    const TitleText(label: "Type"),
                                    DropdownButton<int>(
                                      isExpanded: true,
                                      icon: const SizedBox(),
                                      hint: const Text("Choose Leave Type"),
                                      underline: const SizedBox(),
                                      items: leaveDataProvider.leaveTypeList.map((type) {
                                        return DropdownMenuItem(
                                          child: Text(type.name,style: TextStyle(color: Colors.grey[800])),
                                          value: type.leaveTypeId,
                                        );
                                      }).toList(),
                                      value: leaveTypeDropdownValue,
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
                                    const TitleText(label: "To Date"),
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
                                    const TitleText(label: "Description"),
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
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
