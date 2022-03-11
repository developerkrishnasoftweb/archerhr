import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:flutter/material.dart';

class EducationProfileScreen extends StatefulWidget {
  EducationProfileScreen({Key key, this.profileProvider}) : super(key: key);
  ProfileProvider profileProvider;

  @override
  _EducationProfileScreenState createState() => _EducationProfileScreenState();
}

class _EducationProfileScreenState extends State<EducationProfileScreen> {
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
        title: const Text("Education Details"),
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
                      label: Text('Course'),
                    ),
                    DataColumn(
                      label: Text('Institute'),
                    ),
                    DataColumn(
                      label: Text('Elective'),
                    ),
                    DataColumn(
                      label: Text('From'),
                    ),
                    DataColumn(
                      label: Text('To'),
                    ),
                    DataColumn(
                      label: Text('Univ Location'),
                    ),
                  ],
                  rows: profileProvider.employeeEducationList
                      .map(
                        (e) => DataRow(cells: [
                          DataCell(Text(e.graduation)),
                          DataCell(Text(e.university)),
                          DataCell(Text(e.elective)),
                          DataCell(Text(e.yos)),
                          DataCell(Text(e.yoc)),
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
