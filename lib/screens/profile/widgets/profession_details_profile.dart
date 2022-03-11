import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProfessionDetailsProfileScreen extends StatefulWidget {
  ProfessionDetailsProfileScreen({Key key, this.profileProvider}) : super(key: key);
  ProfileProvider profileProvider;

  @override
  _ProfessionDetailsProfileScreenState createState() => _ProfessionDetailsProfileScreenState();
}

class _ProfessionDetailsProfileScreenState extends State<ProfessionDetailsProfileScreen> {
  TextEditingController dateOfJoinController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController buController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController reportingManagerController = TextEditingController();
  TextEditingController bandController = TextEditingController();
  ProfileProvider profileProvider;

  @override
  void initState() {
    super.initState();
    profileProvider = widget.profileProvider;
    String dateOfJoin = DateFormat('MM-dd-yyyy').format(DateTime.parse(profileProvider.employeeDetail.dOJ));
    dateOfJoinController.text = dateOfJoin;
    branchController.text = profileProvider.employeeDetail.branchName;
    buController.text = profileProvider.employeeDetail.buName;
    departmentController.text = profileProvider.employeeDetail.dept;
    designationController.text = profileProvider.employeeDetail.desg;
    reportingManagerController.text =
        profileProvider.employeeDetail.manger.firstName + "," + profileProvider.employeeDetail.manger.lastName;
    bandController.text = profileProvider.employeeDetail.bandName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(232, 238, 240, 1),
      appBar: AppBar(
        title: const Text("Profession Details"),
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const TitleText(
                            label: "Date of Join",
                          ),
                          Input(
                            controller: dateOfJoinController,
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
                            label: "Branch",
                          ),
                          Input(
                            controller: branchController,
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
                sizeBox10h,
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const TitleText(
                            label: "BU",
                          ),
                          Input(
                            controller: buController,
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
                            label: "Department",
                          ),
                          Input(
                            controller: departmentController,
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
                sizeBox10h,
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const TitleText(
                            label: "Designation",
                          ),
                          Input(
                            controller: designationController,
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
                            label: "Reporting Manager",
                          ),
                          Input(
                            controller: reportingManagerController,
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
                sizeBox10h,
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const TitleText(
                            label: "Band",
                          ),
                          Input(
                            controller: bandController,
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
        ),
      ),
    );
  }
}
