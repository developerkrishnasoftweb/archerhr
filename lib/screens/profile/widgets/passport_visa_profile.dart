import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/table_icon_tap.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PassportVisaProfileScreen extends StatefulWidget {
  PassportVisaProfileScreen({Key key,this.profileProvider}) : super(key: key);
  ProfileProvider profileProvider;
  @override
  _PassportVisaProfileScreenState createState() => _PassportVisaProfileScreenState();
}

class _PassportVisaProfileScreenState extends State<PassportVisaProfileScreen> {
  ProfileProvider profileProvider;

  TextEditingController passportNoController = TextEditingController();
  TextEditingController oldPassportNoController = TextEditingController();
  TextEditingController nameInPassportController = TextEditingController();
  TextEditingController issueDateController = TextEditingController();
  TextEditingController issuePlaceController = TextEditingController();
  TextEditingController validTillController = TextEditingController();
  TextEditingController issueCountryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileProvider = widget.profileProvider;

    String issueDate = DateFormat('MM-dd-yyyy').format(DateTime.parse(profileProvider.employeePassport.issueDate));
    String validDate = DateFormat('MM-dd-yyyy').format(DateTime.parse(profileProvider.employeePassport.validity));

    passportNoController.text = profileProvider.employeePassport.passportNo;
    oldPassportNoController.text = profileProvider.employeePassport.oldpassportNo;
    nameInPassportController.text = profileProvider.employeePassport.nameinPassport;
    issueDateController.text = issueDate;
    validTillController.text = validDate;
    issuePlaceController.text = profileProvider.employeePassport.issuePlace;
    issueCountryController.text = profileProvider.employeePassport.country == null ? "N/A" : profileProvider.employeePassport.country;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(232, 238, 240, 1),
      appBar: AppBar(
        title: const Text("Passport & Visa Details"),
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Passport",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              sizeBox20h,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const TitleText(
                          label: "Passport No",
                        ),
                        Input(
                          controller: passportNoController,
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
                          label: "Old Passport No",
                        ),
                        Input(
                          controller: oldPassportNoController,
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
                            label: "Name in Passport"
                        ),
                        Input(
                          controller: nameInPassportController,
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
                          label: "Issue Date",
                        ),
                        Input(
                          controller: issueDateController,
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
                            label: "Valid Till"
                        ),
                        Input(
                          controller: validTillController,
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
                          label: "Issue Place",
                        ),
                        Input(
                          controller: issuePlaceController,
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
                          label: "Issue Country",
                        ),
                        Input(
                          controller: issueCountryController,
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
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Visa",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              sizeBox10h,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20,
                  horizontalMargin: 5,
                  headingRowHeight: 40,
                  columns: const [
                    DataColumn(
                      label: Text('Visa No'),
                    ),
                    DataColumn(
                      label: Text('Country'),
                    ),
                    DataColumn(
                      label: Text('Visa Type'),
                    ),
                    DataColumn(
                      label: Text('Valid Till'),
                    ),
                  ],
                  rows: profileProvider.employeeVisaList
                      .map(
                        (e) => DataRow(cells: [
                      DataCell(Text(e.visaNo)),
                      DataCell(Text(e.country)),
                      DataCell(Text(e.visaType)),
                      DataCell(Text(e.visaValidity)),
                    ]),
                  )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
