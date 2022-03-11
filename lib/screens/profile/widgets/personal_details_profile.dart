import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PersonalDetailsProfileScreen extends StatefulWidget {
  PersonalDetailsProfileScreen({Key key, this.profileProvider}) : super(key: key);
  ProfileProvider profileProvider;

  @override
  _PersonalDetailsProfileScreenState createState() => _PersonalDetailsProfileScreenState();
}

class _PersonalDetailsProfileScreenState extends State<PersonalDetailsProfileScreen> {
  ProfileProvider profileProvider;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController maidenNameController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController mothersNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController anniversaryController = TextEditingController();
  TextEditingController spouseNameController = TextEditingController();
  TextEditingController officialEmailController = TextEditingController();
  TextEditingController personalEmailController = TextEditingController();
  TextEditingController landLineNumberController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emergencyNumberController = TextEditingController();
  TextEditingController emergencyNameController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();

  TextEditingController genderController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController maritalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileProvider = widget.profileProvider;

    String dateOfBirth = DateFormat('MM-dd-yyyy').format(DateTime.parse(profileProvider.employeeDetail.dOB));
    String marriageDate = DateFormat('MM-dd-yyyy').format(DateTime.parse(profileProvider.employeeDetail.marriageDate));
    firstNameController.text = profileProvider.employeeDetail.firstName;
    lastNameController.text = profileProvider.employeeDetail.lastName;
    middleNameController.text = profileProvider.employeeDetail.middleName;
    maidenNameController.text = profileProvider.employeeDetail.maidenName;
    fathersNameController.text = profileProvider.employeeDetail.fatherName;
    mothersNameController.text = profileProvider.employeeDetail.motherName;
    dateOfBirthController.text = dateOfBirth;
    anniversaryController.text = marriageDate;
    spouseNameController.text = profileProvider.employeeDetail.spouseName;
    officialEmailController.text = profileProvider.employeeDetail.priEmail;
    personalEmailController.text = profileProvider.employeeDetail.secEmail;
    landLineNumberController.text = profileProvider.employeeDetail.landline;
    mobileNumberController.text = profileProvider.employeeDetail.mobileno;
    emergencyNameController.text = profileProvider.employeeDetail.emrContact;
    emergencyNumberController.text = profileProvider.employeeDetail.emrNo;
    bloodGroupController.text = profileProvider.employeeDetail.bloodgroup;
    birthPlaceController.text = profileProvider.employeeDetail.placeofBirth;
    aboutMeController.text = profileProvider.employeeDetail.aboutMe;

    genderController.text = profileProvider.employeeDetail.genderName;
    nationalityController.text = profileProvider.employeeDetail.nationalityName;
    maritalController.text = profileProvider.employeeDetail.marital;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(232, 238, 240, 1),
      appBar: AppBar(
        title: const Text("Personal Details"),
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
                            label: "First Name",
                          ),
                          Input(
                            controller: firstNameController,
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
                            label: "Middle Name",
                          ),
                          Input(
                            controller: middleNameController,
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
                            label: "Last Name",
                          ),
                          Input(
                            controller: lastNameController,
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
                            label: "Maiden Name",
                          ),
                          Input(
                            controller: maidenNameController,
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
                            label: "Father's Name",
                          ),
                          Input(
                            controller: fathersNameController,
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
                            label: "Mother's Name",
                          ),
                          Input(
                            controller: mothersNameController,
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
                            label: "Date of Birth",
                          ),
                          Input(
                            controller: dateOfBirthController,
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
                            label: "Birth Place",
                          ),
                          Input(
                            controller: birthPlaceController,
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
                            label: "Gender",
                          ),
                          Input(
                            controller: genderController,
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
                            label: "Nationality",
                          ),
                          Input(
                            controller: nationalityController,
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
                            label: "Marital",
                          ),
                          Input(
                            controller: maritalController,
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
                            label: "Anniversary",
                          ),
                          Input(
                            controller: anniversaryController,
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
                            label: "Landline Number",
                          ),
                          Input(
                            controller: landLineNumberController,
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
                            label: "Mobile Number",
                          ),
                          Input(
                            controller: mobileNumberController,
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
                            label: "Spouse Name(if married)",
                          ),
                          Input(
                            controller: spouseNameController,
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
                            label: "Official Email",
                          ),
                          Input(
                            controller: officialEmailController,
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
                            label: "Personal Email",
                          ),
                          Input(
                            controller: personalEmailController,
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
                            label: "Emergency Contact Name & Number",
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Input(
                                  controller: emergencyNameController,
                                  readOnly: true,
                                  inputDecoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              sizeBox10w,
                              Expanded(
                                child: Input(
                                  controller: emergencyNumberController,
                                  readOnly: true,
                                  inputDecoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //sizeBox10w,
                  ],
                ),
                sizeBox10h,
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const TitleText(
                            label: "Blood Group",
                          ),
                          Input(
                            controller: bloodGroupController,
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
                    "About Me",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Input(
                            controller: aboutMeController,
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
