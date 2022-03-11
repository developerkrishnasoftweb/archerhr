/*
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
import 'package:flutter/material.dart';

class SelectCategoryScreen extends StatefulWidget {
  SelectCategoryScreen({Key key, this.index}) : super(key: key);
  int index;

  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    widget.index == 0
        ? const PersonalDetailsProfileScreen()
        : widget.index == 1
            ? const ProfessionDetailsProfileScreen()
            : widget.index == 2
                ? const AddressProfileScreen()
                : widget.index == 3
                    ? const EducationProfileScreen()
                    : widget.index == 4
                        ? const ExperienceProfileScreen()
                        : widget.index == 5
                            ? const SkillsProfileScreen()
                            : widget.index == 6
                                ? const FamilyReferencesProfileScreen()
                                : widget.index == 7
                                    ? const StatutoryProfileScreen()
                                    : widget.index == 8
                                        ? const BankProfileScreen()
                                        : const PassportVisaProfileScreen();
  }
}
*/
