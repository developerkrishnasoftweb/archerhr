import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:archerhr_mobile/screens/widgets/table_icon_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExperienceProfileScreen extends StatefulWidget {
  ExperienceProfileScreen({Key key, this.profileProvider}) : super(key: key);
  ProfileProvider profileProvider;

  @override
  _ExperienceProfileScreenState createState() => _ExperienceProfileScreenState();
}

class _ExperienceProfileScreenState extends State<ExperienceProfileScreen> {
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
        title: const Text("Experience Details"),
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 30,
                  horizontalMargin: 20,
                  headingRowHeight: 40,
                  columns: const [
                    DataColumn(
                      label: Text('Company'),
                    ),
                    DataColumn(
                      label: Text('Designation'),
                    ),
                    DataColumn(
                      label: Text('Employment Type'),
                    ),
                    DataColumn(
                      label: Text('From'),
                    ),
                    DataColumn(
                      label: Text('To	'),
                    ),
                    DataColumn(
                      label: Text('Location'),
                    ),
                  ],
                  rows: profileProvider.employeeExperienceList
                      .map(
                        (e) => DataRow(cells: [
                      DataCell(Text(e.companyName)),
                      DataCell(Text(e.position)),
                      DataCell(Text(e.type)),
                      DataCell(Text(e.doj)),
                      DataCell(Text(e.dor)),
                      DataCell(Text(e.city + "," + e.state + "," + e.country)),
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
