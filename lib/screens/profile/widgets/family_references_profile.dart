import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FamilyReferencesProfileScreen extends StatefulWidget {
  FamilyReferencesProfileScreen({Key key, this.profileProvider}) : super(key: key);
  ProfileProvider profileProvider;

  @override
  _FamilyReferencesProfileScreenState createState() => _FamilyReferencesProfileScreenState();
}

class _FamilyReferencesProfileScreenState extends State<FamilyReferencesProfileScreen> {
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
        title: const Text("Family & References"),
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                sizeBox20h,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "FAMILY DETAILS",
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
                    columnSpacing: 30,
                    horizontalMargin: 20,
                    dividerThickness: 1,
                    headingRowHeight: 40,
                    columns: const [
                      DataColumn(
                        label: Text('Full Name'),
                      ),
                      DataColumn(
                        label: Text('DOB'),
                      ),
                      DataColumn(
                        label: Text('Age'),
                      ),
                      DataColumn(
                        label: Text('Gender'),
                      ),
                      DataColumn(
                        label: Text('Relationships'),
                      ),
                      DataColumn(
                        label: Text('Occupation'),
                      ),
                      DataColumn(
                        label: Text('Dependent'),
                      ),
                    ],
                    rows: profileProvider.employeeFamilyList
                        .map(
                          (e) => DataRow(cells: [
                            DataCell(Text(e.name)),
                            DataCell(Text(e.dob)),
                            DataCell(Text("${e.age}")),
                            DataCell(Text(e.gender)),
                            DataCell(Text(e.relationship)),
                            DataCell(Text(e.occupation)),
                            DataCell(e.dependent == true ? const Text("True") : const Text("False")),
                          ]),
                        )
                        .toList(),
                  ),
                ),
                sizeBox20h,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "REFERENCE",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
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
