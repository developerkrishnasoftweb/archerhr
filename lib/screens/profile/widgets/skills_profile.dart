import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:archerhr_mobile/screens/widgets/table_icon_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkillsProfileScreen extends StatefulWidget {
  SkillsProfileScreen({Key key, this.profileProvider}) : super(key: key);
  ProfileProvider profileProvider;

  @override
  _SkillsProfileScreenState createState() => _SkillsProfileScreenState();
}

class _SkillsProfileScreenState extends State<SkillsProfileScreen> {
  ProfileProvider profileProvider;

  @override
  void initState() {
    super.initState();
    profileProvider = widget.profileProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(232, 238, 240, 1),
      appBar: AppBar(
        title: const Text("Skills Details"),
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Technical Skills",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 60,
                    horizontalMargin: 20,
                    headingRowHeight: 40,
                    columns: const [
                      DataColumn(
                        label: Text('Skill'),
                      ),
                      DataColumn(
                        label: Text('Exp'),
                      ),
                      DataColumn(
                        label: Text('Self Rating'),
                      ),
                    ],
                    rows: profileProvider.employeeSkillList
                        .map(
                          (e) => DataRow(cells: [
                        DataCell(Text(e.skill)),
                        DataCell(Text("${e.exp}")),
                        DataCell(Text("${e.scale}")),
                      ]),
                    )
                        .toList(),
                  ),
                ),
                sizeBox20h,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Languages",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 30,
                    horizontalMargin: 20,
                    headingRowHeight: 40,
                    columns: const [
                      DataColumn(
                        label: Text('Language'),
                      ),
                      DataColumn(
                        label: Text('Speak'),
                      ),
                      DataColumn(
                        label: Text('Read'),
                      ),
                      DataColumn(
                        label: Text('Write'),
                      ),
                      DataColumn(
                        label: Text('Mother Tongue'),
                      ),
                    ],
                    rows: profileProvider.employeeLanguageList
                        .map(
                          (e) => DataRow(cells: [
                        DataCell(Text(e.lang)),
                        DataCell(e.speak == true ? const Icon(Icons.check_rounded) : const Icon(Icons.close_rounded)),
                        DataCell(e.read == true ? const Icon(Icons.check_rounded) : const Icon(Icons.close_rounded)),
                        DataCell(e.write == true ? const Icon(Icons.check_rounded) : const Icon(Icons.close_rounded)),
                        DataCell(e.isMotherTongue == true ? const Icon(Icons.check_rounded) : const Icon(Icons.close_rounded)),
                      ]),
                    )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
