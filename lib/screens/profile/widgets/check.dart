/*
import 'dart:io';

import 'package:archerhr_mobile/const/const_class.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:archerhr_mobile/screens/profile/widgets/address_profile.dart';
import 'package:archerhr_mobile/screens/profile/widgets/bank_profile.dart';
import 'package:archerhr_mobile/screens/profile/widgets/education_profile.dart';
import 'package:archerhr_mobile/screens/profile/widgets/experience_profile.dart';
import 'package:archerhr_mobile/screens/profile/widgets/family_references_profile.dart';
import 'package:archerhr_mobile/screens/profile/widgets/passport_visa_profile.dart';
import 'package:archerhr_mobile/screens/profile/widgets/personal_details_profile.dart';
import 'package:archerhr_mobile/screens/profile/widgets/profession_details_profile.dart';
import 'package:archerhr_mobile/screens/profile/widgets/skills_profile.dart';
import 'package:archerhr_mobile/screens/profile/widgets/statutory_profile.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key key}) : super(key: key);

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  ProfileProvider profileProvider;
  String imagePath;
  final picker = ImagePicker();

  List<Category> categories = [
    Category("Personal Details", Icons.person),
    Category('Profession Details', Icons.alternate_email_outlined),
    Category('Address', Icons.location_on_outlined),
    Category('Education', Icons.school_outlined),
    Category('Experience', Icons.person_pin),
    Category('Skills', Icons.account_tree_outlined),
    Category('Family & References', Icons.family_restroom_outlined),
    Category('Statutory', Icons.details),
    Category('Bank', Icons.comment_bank_outlined),
    Category('Passport & Visa', Icons.file_copy_outlined),
  ];

  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appBarColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Palette.appBarColor,
        titleSpacing: 0,
        title: Text(
          "Profile",
          style: TextStyle(
            //color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            //color: Colors.black,
          ),
        ),
      ),
      body: Consumer<ProfileProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          overflow: Overflow.visible,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: imagePath != null
                                  ? Container(
                                      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.file(
                                          File(imagePath),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        "assets/images/baby.jpeg",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            Positioned(
                              bottom: -10,
                              right: -10,
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
                                    ),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: const Icon(Icons.camera, size: 25, color: Palette.appBarColor),
                                            title: Text(
                                              'Camera',
                                              style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w500),
                                            ),
                                            horizontalTitleGap: 0,
                                            onTap: () async {
                                              Navigator.pop(context);
                                              final pickedFile = await picker.pickImage(source: ImageSource.camera);
                                              if (pickedFile != null) {
                                                File croppedFile = await ImageCropper().cropImage(
                                                  sourcePath: pickedFile.path,
                                                  aspectRatioPresets: [
                                                    CropAspectRatioPreset.square,
                                                    CropAspectRatioPreset.ratio3x2,
                                                    CropAspectRatioPreset.original,
                                                    CropAspectRatioPreset.ratio4x3,
                                                    CropAspectRatioPreset.ratio16x9
                                                  ],
                                                  androidUiSettings: const AndroidUiSettings(
                                                      toolbarTitle: 'Cropper',
                                                      toolbarColor: Palette.appBarColor,
                                                      toolbarWidgetColor: Colors.white,
                                                      initAspectRatio: CropAspectRatioPreset.original,
                                                      lockAspectRatio: false),
                                                  iosUiSettings: const IOSUiSettings(
                                                    minimumAspectRatio: 1.0,
                                                  ),
                                                );
                                                if (croppedFile != null) {
                                                  setState(() {
                                                    imagePath = croppedFile.path;
                                                  });
                                                }
                                              }
                                            },
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.photo, size: 25, color: Palette.appBarColor),
                                            title: Text(
                                              'Gallery',
                                              style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w500),
                                            ),
                                            horizontalTitleGap: 0,
                                            onTap: () async {
                                              Navigator.pop(context);
                                              final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                              if (pickedFile != null) {
                                                File croppedFile = await ImageCropper().cropImage(
                                                  sourcePath: pickedFile.path,
                                                  aspectRatioPresets: [
                                                    CropAspectRatioPreset.square,
                                                    CropAspectRatioPreset.ratio3x2,
                                                    CropAspectRatioPreset.original,
                                                    CropAspectRatioPreset.ratio4x3,
                                                    CropAspectRatioPreset.ratio16x9
                                                  ],
                                                  androidUiSettings: const AndroidUiSettings(
                                                      toolbarTitle: 'Cropper',
                                                      toolbarColor: Palette.appBarColor,
                                                      toolbarWidgetColor: Colors.white,
                                                      initAspectRatio: CropAspectRatioPreset.original,
                                                      lockAspectRatio: false),
                                                  iosUiSettings: const IOSUiSettings(
                                                    minimumAspectRatio: 1.0,
                                                  ),
                                                );
                                                if (croppedFile != null) {
                                                  setState(() {
                                                    imagePath = croppedFile.path;
                                                  });
                                                }
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            )
                          ],
                        ),
                        sizeBox20w,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.employeeDetail.firstName + "," + provider.employeeDetail.lastName,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            sizeBox10h,
                            Text(
                              provider.employeeDetail.username,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    sizeBox20h,
                    Row(
                      children: [
                        const Icon(Icons.call_outlined, size: 25, color: Colors.white),
                        sizeBox20w,
                        Text(
                          provider.employeeDetail.mobileno,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    sizeBox10h,
                    Row(
                      children: [
                        const Icon(Icons.mail_outline_rounded, size: 25, color: Colors.white),
                        sizeBox20w,
                        Text(
                          provider.employeeDetail.priEmail,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          Card(
                            elevation: 10,
                            color: Colors.transparent,
                            child: Container(
                              height: 50.h,
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30.r)), color: Colors.white),
                              child: GestureDetector(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      */
/*showModalBottomSheet(
                    isScrollControlled:true,
                    context: context,
                    backgroundColor: Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20.r),topLeft: Radius.circular(20.r)),
                    ),
                    builder: (BuildContext context) => FractionallySizedBox(
                      heightFactor: 0.75,
                      child: PersonalDetailsProfileScreen(
                        profileProvider: profileProvider,
                      ),
                    ),
                  );*//*

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PersonalDetailsProfileScreen(
                                            profileProvider: profileProvider,
                                          ),
                                        ),
                                      );
                                      break;
                                    case 1:
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => const ProfessionDetailsProfileScreen(),
                                      );
                                      break;
                                    case 2:
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => AddressProfileScreen(
                                          profileProvider: profileProvider,
                                        ),
                                      );
                                      break;
                                    case 3:
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => EducationProfileScreen(
                                          profileProvider: profileProvider,
                                        ),
                                      );
                                      break;
                                    case 4:
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => ExperienceProfileScreen(
                                          profileProvider: profileProvider,
                                        ),
                                      );
                                      break;
                                    case 5:
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => SkillsProfileScreen(
                                          profileProvider: profileProvider,
                                        ),
                                      );
                                      break;
                                    case 6:
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => FamilyReferencesProfileScreen(
                                          profileProvider: profileProvider,
                                        ),
                                      );
                                      break;
                                    case 7:
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => StatutoryProfileScreen(
                                          profileProvider: profileProvider,
                                        ),
                                      );
                                      break;
                                    case 8:
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => BankProfileScreen(
                                          profileProvider: profileProvider,
                                        ),
                                      );
                                      break;
                                    default:
                                     */
/* showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => PassportVisaProfileScreen(
                                          profileProvider: profileProvider,
                                        ),
                                      );*//*

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PassportVisaProfileScreen(
                                            profileProvider: profileProvider,
                                          ),
                                        ),
                                      );
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0.w),
                                      child: Row(
                                        children: [
                                          Icon(
                                            categories[index].icon,
                                            size: 25,
                                            color: Palette.appBarColor,
                                          ),
                                          sizeBox10w,
                                          Text(
                                            categories[index].name,
                                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.0.w),
                                      child: const Icon(Icons.arrow_forward_ios, color: Palette.appBarColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          sizeBox5h
                        ],
                      ),
                    );
                  }),
            ],
          ),
        );
      }),
    );
  }
}
*/
