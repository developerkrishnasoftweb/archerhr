import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddressProfileScreen extends StatefulWidget {
  AddressProfileScreen({Key key, this.profileProvider}) : super(key: key);
  ProfileProvider profileProvider;

  @override
  _AddressProfileScreenState createState() => _AddressProfileScreenState();
}

class _AddressProfileScreenState extends State<AddressProfileScreen> {
  ProfileProvider profileProvider;
  TextEditingController communicationLine1Controller = TextEditingController();
  TextEditingController communicationLine2Controller = TextEditingController();
  TextEditingController communicationLine3Controller = TextEditingController();
  TextEditingController communicationCityController = TextEditingController();
  TextEditingController communicationPostalCodeController = TextEditingController();
  TextEditingController communicationStayingFromController = TextEditingController();
  TextEditingController communicationCountryController = TextEditingController();
  TextEditingController communicationStateController = TextEditingController();

  TextEditingController permanentLine1Controller = TextEditingController();
  TextEditingController permanentLine2Controller = TextEditingController();
  TextEditingController permanentLine3Controller = TextEditingController();
  TextEditingController permanentCityController = TextEditingController();
  TextEditingController permanentPostalCodeController = TextEditingController();
  TextEditingController permanentStayingFromController = TextEditingController();
  TextEditingController permanentCountryController = TextEditingController();
  TextEditingController permanentStateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileProvider = widget.profileProvider;

    String comStayFrom = DateFormat('dd-MMM-yyyy').format(DateTime.parse(profileProvider.employeeDetail.stayFrom));
    String perStayFrom = DateFormat('dd-MMM-yyyy').format(DateTime.parse(profileProvider.employeeDetail.permFrom));

    communicationLine1Controller.text = profileProvider.employeeDetail.comLine1;
    communicationLine2Controller.text = profileProvider.employeeDetail.comLine2;
    communicationLine3Controller.text = profileProvider.employeeDetail.comLine3;
    communicationCityController.text = profileProvider.employeeDetail.comCity;
    communicationStateController.text = profileProvider.employeeDetail.comStateName;
    communicationPostalCodeController.text = profileProvider.employeeDetail.comPostcode;
    communicationStayingFromController.text = comStayFrom;
    communicationCountryController.text = profileProvider.employeeDetail.comCountryName;

    permanentLine1Controller.text = profileProvider.employeeDetail.permLine1;
    permanentLine2Controller.text = profileProvider.employeeDetail.permLine2;
    permanentLine3Controller.text = profileProvider.employeeDetail.permLine3;
    permanentCityController.text = profileProvider.employeeDetail.permCity;
    permanentPostalCodeController.text = profileProvider.employeeDetail.permPostcode;
    permanentStayingFromController.text = perStayFrom;
    permanentCountryController.text = profileProvider.employeeDetail.permCountryName;
    permanentStateController.text = profileProvider.employeeDetail.permStateName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(232, 238, 240, 1),
      appBar: AppBar(
        title: const Text("Address Details"),
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Communication Address :",
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
                            label: "Line 1",
                          ),
                          Input(
                            controller: communicationLine1Controller,
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
                            label: "Line 2",
                          ),
                          Input(
                            controller: communicationLine2Controller,
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
                            label: "Line 3",
                          ),
                          Input(
                            controller: communicationLine3Controller,
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
                            label: "Country",
                          ),
                          Input(
                            controller: communicationCountryController,
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
                            label: "State",
                          ),
                          Input(
                            controller: communicationCountryController,
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
                            label: "City",
                          ),
                          Input(
                            controller: communicationCityController,
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
                            label: "Postal code",
                          ),
                          Input(
                            controller: communicationPostalCodeController,
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
                            label: "Staying From",
                          ),
                          Input(
                            controller: communicationStayingFromController,
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
                    "Permanent Address :",
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
                            label: "Line 1",
                          ),
                          Input(
                            controller: permanentLine1Controller,
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
                            label: "Line 2",
                          ),
                          Input(
                            controller: permanentLine2Controller,
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
                            label: "Line 3",
                          ),
                          Input(
                            controller: permanentLine3Controller,
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
                            label: "Country",
                          ),
                          Input(
                            controller: permanentCountryController,
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
                            label: "State",
                          ),
                          Input(
                            controller: permanentStateController,
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
                            label: "City",
                          ),
                          Input(
                            controller: permanentCityController,
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
                            label: "Postal code",
                          ),
                          Input(
                            controller: permanentPostalCodeController,
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
                            label: "Staying From",
                          ),
                          Input(
                            controller: permanentStayingFromController,
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
