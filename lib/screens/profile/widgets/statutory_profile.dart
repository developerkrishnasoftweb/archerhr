import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class StatutoryProfileScreen extends StatefulWidget {
  StatutoryProfileScreen({Key key, this.profileProvider}) : super(key: key);
  ProfileProvider profileProvider;

  @override
  _StatutoryProfileScreenState createState() => _StatutoryProfileScreenState();
}

class _StatutoryProfileScreenState extends State<StatutoryProfileScreen> {
  ProfileProvider profileProvider;
  int workPermitTypeValue;
  int healthCardType1Value;
  bool salaryTexable;
  bool pfApplicable;
  bool gratuity;
  bool insuranceCovered;

  TextEditingController adharCardNoController = TextEditingController();
  TextEditingController panCardNoController = TextEditingController();
  TextEditingController drivingLicenseController = TextEditingController();
  TextEditingController workPermitController = TextEditingController();
  TextEditingController workPermitNoController = TextEditingController();
  TextEditingController taxStateController = TextEditingController();
  TextEditingController lwfLocationController = TextEditingController();
  TextEditingController pfNoController = TextEditingController();
  TextEditingController pfStartDateController = TextEditingController();
  TextEditingController pfLocationController = TextEditingController();
  TextEditingController pfNominee1Controller = TextEditingController();
  TextEditingController pfNominee2Controller = TextEditingController();
  TextEditingController healthCard2Controller = TextEditingController();
  TextEditingController healthCard1Controller = TextEditingController();
  TextEditingController uanNoController = TextEditingController();

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
    profileProvider = widget.profileProvider;

    String pfStartDate = DateFormat('MM-dd-yyyy').format(DateTime.parse(profileProvider.employeeStatutory.pFStartDate));
    adharCardNoController.text = profileProvider.employeeStatutory.nationalIdNo;
    panCardNoController.text = profileProvider.employeeStatutory.pANCardNo;
    drivingLicenseController.text = profileProvider.employeeStatutory.drivingLicense;
    workPermitController.text = profileProvider.employeeStatutory.workPermitName;
    workPermitNoController.text = profileProvider.employeeStatutory.workPermitNo;
    salaryTexable = profileProvider.employeeStatutory.taxApplicable;
    pfApplicable = profileProvider.employeeStatutory.pFApplicable;
    gratuity = profileProvider.employeeStatutory.gratuity;
    insuranceCovered = profileProvider.employeeStatutory.insuranceCovered;
    taxStateController.text = profileProvider.employeeStatutory.taxStateId.toString();
    lwfLocationController.text = profileProvider.employeeStatutory.lWFLocation;
    pfNoController.text = profileProvider.employeeStatutory.pFNo;
    pfStartDateController.text = pfStartDate;
    pfLocationController.text = profileProvider.employeeStatutory.pFLocation;
    pfNominee1Controller.text = profileProvider.employeeStatutory.pFNominee1;
    pfNominee2Controller.text = profileProvider.employeeStatutory.pFNominee2;
    healthCard1Controller.text = profileProvider.employeeStatutory.healthCardNo1;
    healthCard2Controller.text = profileProvider.employeeStatutory.healthCardNo2 == null ? "N/A" : profileProvider.employeeStatutory.healthCardNo2;
    uanNoController.text = profileProvider.employeeStatutory.uANNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(232, 238, 240, 1),
      appBar: AppBar(
        title: const Text("Statutory Details"),
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
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const TitleText(
                            label: "Aadhar No",
                          ),
                          Input(
                            controller: adharCardNoController,
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
                            label: "Driving License No",
                          ),
                          Input(
                            controller: drivingLicenseController,
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
                            label: "PAN No",
                          ),
                          Input(
                            controller: panCardNoController,
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
                            label: "Work Permit",
                          ),
                          Input(
                            controller: workPermitController,
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
                            label: "Work Permit No",
                          ),
                          Input(
                            controller: workPermitNoController,
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
                            label: "Salary Taxable",
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Checkbox(
                              value: salaryTexable,
                              fillColor: MaterialStateProperty.all(Colors.blue),
                              onChanged: (bool value) {},
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
                            label: "Tax State",
                          ),
                          Input(
                            controller: taxStateController,
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
                            label: "LWF Location",
                          ),
                          Input(
                            controller: lwfLocationController,
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
                            label: "Gratuity",
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Checkbox(
                              value: gratuity,
                              fillColor: MaterialStateProperty.all(Colors.blue),
                              onChanged: (bool value) {},
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
                            label: "PF Applicable",
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Checkbox(
                              value: pfApplicable,
                              fillColor: MaterialStateProperty.all(Colors.blue),
                              onChanged: (bool value) {},
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
                            label: "PF No",
                          ),
                          Input(
                            controller: pfNoController,
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
                            label: "PF Start Date",
                          ),
                          Input(
                            controller: pfStartDateController,
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
                            label: "PF Location",
                          ),
                          Input(
                            controller: pfLocationController,
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
                            label: "Insurance Covered",
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Checkbox(
                              value: insuranceCovered,
                              fillColor: MaterialStateProperty.all(Colors.blue),
                              onChanged: (bool value) {},
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
                            label: "PF Nominee 1",
                          ),
                          Input(
                            controller: pfNominee1Controller,
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
                            label: "PF Nominee 2",
                          ),
                          Input(
                            controller: pfNominee2Controller,
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
                            label: "HealthCard 1",
                          ),
                          Input(
                            controller: healthCard1Controller,
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
                            label: "HealthCard 2",
                          ),
                          Input(
                            controller: healthCard2Controller,
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
                            label: "UAN No",
                          ),
                          Input(
                            controller: uanNoController,
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
