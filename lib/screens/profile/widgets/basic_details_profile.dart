import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BasicDetailsProfileScreen extends StatefulWidget {
  BasicDetailsProfileScreen({Key key,this.profileProvider}) : super(key: key);
  ProfileProvider profileProvider;

  @override
  _BasicDetailsProfileScreenState createState() => _BasicDetailsProfileScreenState();
}

class _BasicDetailsProfileScreenState extends State<BasicDetailsProfileScreen> {
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

  TextEditingController communicationLine1Controller = TextEditingController();
  TextEditingController communicationLine2Controller = TextEditingController();
  TextEditingController communicationLine3Controller = TextEditingController();
  TextEditingController communicationCityController = TextEditingController();
  TextEditingController communicationPostalCodeController = TextEditingController();
  TextEditingController communicationStayingFromController = TextEditingController();

  TextEditingController permanentLine1Controller = TextEditingController();
  TextEditingController permanentLine2Controller = TextEditingController();
  TextEditingController permanentLine3Controller = TextEditingController();
  TextEditingController permanentCityController = TextEditingController();
  TextEditingController permanentPostalCodeController = TextEditingController();
  TextEditingController permanentStayingFromController = TextEditingController();

  TextEditingController dateOfJoinController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();

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
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    profileProvider.clear();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
        child: Column(
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
                        label: "Last Name",
                      ),
                      Input(
                        controller: lastNameController,
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
                        label: "Father's Name",
                      ),
                      Input(
                        controller: fathersNameController,
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
                        label: "Date of Birth",
                      ),
                      Input(
                        controller: dateOfBirthController,
                        readOnly: true,
                        onTap: () => dateTap(context, dateOfBirthController),
                      ),
                    ],
                  ),
                ),
                sizeBox10w,
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Gender Type",
                      ),
                      Input(
                        controller: mothersNameController,
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
                        label: "Nationality Type",
                      ),
                      Input(
                        controller: fathersNameController,
                      ),
                    ],
                  ),
                ),
                sizeBox10w,
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Marital Type",
                      ),
                      Input(
                        controller: mothersNameController,
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
                        label: "Anniversary",
                      ),
                      Input(
                        controller: anniversaryController,
                        readOnly: true,
                        onTap: () => dateTap(context, anniversaryController),
                      ),
                    ],
                  ),
                ),
                //sizeBox10w,

              ],
            ),
            sizeBox20h,
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
                        label: "Official Email",
                      ),
                      Input(
                        controller: officialEmailController,
                      ),
                    ],
                  ),
                ),
                sizeBox10w,
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Personal Email",
                      ),
                      Input(
                        controller: personalEmailController,
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
                        label: "Landline Number",
                      ),
                      Input(
                        controller: landLineNumberController,
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
                        label: "Emergency Number",
                      ),
                      Input(
                        controller: emergencyNumberController,
                      ),
                    ],
                  ),
                ),
                //sizeBox10w,

              ],
            ),
            sizeBox20h,
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Emergency Contact Name",
                      ),
                      Input(
                        controller: emergencyNameController,
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
                        label: "Blood Group",
                      ),
                      Input(
                        controller: bloodGroupController,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizeBox20h,
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
                        label: "Line 3",
                      ),
                      Input(
                        controller: communicationLine3Controller,
                      ),
                    ],
                  ),
                ),
                sizeBox10w,
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Choose Country",
                      ),
                      Input(
                        controller: communicationLine2Controller,
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
                        label: "Choose State",
                      ),
                      Input(
                        controller: communicationLine1Controller,
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
                        label: "Postal code",
                      ),
                      Input(
                        controller: communicationPostalCodeController,
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
                        onTap: () => dateTap(context, communicationStayingFromController),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizeBox20h,
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
                        label: "Line 3",
                      ),
                      Input(
                        controller: permanentLine3Controller,
                      ),
                    ],
                  ),
                ),
                sizeBox10w,
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Choose Country",
                      ),
                      Input(
                        controller: communicationLine2Controller,
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
                        label: "Choose State",
                      ),
                      Input(
                        controller: communicationLine1Controller,
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
                        label: "Postal code",
                      ),
                      Input(
                        controller: permanentPostalCodeController,
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
                        onTap: () => dateTap(context, permanentStayingFromController),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizeBox20h,
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Profession Details :",
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
                        label: "Date of Join",
                      ),
                      Input(
                        controller: dateOfJoinController,
                        readOnly: true,
                        onTap: () => dateTap(context, dateOfJoinController),
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
                        controller: permanentStayingFromController,
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
                        label: "BU",
                      ),
                      Input(
                        controller: dateOfJoinController,
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
                        controller: permanentStayingFromController,
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
                        label: "Designation",
                      ),
                      Input(
                        controller: dateOfJoinController,
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
                        controller: permanentStayingFromController,
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
                        label: "Band",
                      ),
                      Input(
                        controller: dateOfJoinController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizeBox20h,
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
            //sizeBox20h,
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Input(
                        controller: aboutMeController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizeBox30h,
            Center(
              child: Container(
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  color: Palette.buttonBackgroundColor,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
