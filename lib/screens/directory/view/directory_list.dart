import 'dart:async';

import 'package:archerhr_mobile/model/directory_list_data_model.dart';
import 'package:archerhr_mobile/provider/directory_list_data_provider.dart';
import 'package:archerhr_mobile/screens/directory/widgets/directory_data_byid.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/table_icon_tap.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EmployeesList extends StatefulWidget {
  const EmployeesList({Key key}) : super(key: key);

  @override
  _EmployeesListState createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  GetDirectoryListProvider getDirectoryListProvider;
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    getDirectoryListProvider = Provider.of<GetDirectoryListProvider>(context, listen: false);
    getDirectoryListProvider.getDirectoryData(context);
  }

  @override
  void dispose() {
    super.dispose();
    getDirectoryListProvider.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(232, 238, 240, 1),
      appBar: AppBar(
        title: const Text("Employee List"),
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Input(
              controller: searchController,
              hintText: "Search Here...",
              //onChanged: searchDirectory,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 20.h),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: SizedBox(
                width: size.width,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    child: Consumer<GetDirectoryListProvider>(builder: (context, provider, child) {
                      if (provider.loading) {
                        return const CircularProgressIndicator(
                          color: Palette.circularProgress,
                        );
                      }
                      if (provider.allEmployeesList.isNotEmpty) {
                        return PaginatedDataTable(
                          rowsPerPage: provider.allEmployeesList.length > 10 ? 10 : provider.allEmployeesList.length,
                          showFirstLastButtons: true,
                          headingRowHeight: 40,
                          columnSpacing: 10,
                          horizontalMargin: 10,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text('Id'),
                            ),
                            DataColumn(
                              label: Text('Name'),
                            ),
                            DataColumn(
                              label: Text('Department'),
                            ),
                            DataColumn(
                              label: Text('Designation'),
                            ),
                            DataColumn(
                              label: Text('Email Address'),
                            ),
                            DataColumn(
                              label: SizedBox(),
                            ),
                          ],
                          source: DirectorySource(directoryList: provider.allEmployeesList, context: context),
                        );
                      } else {
                        return Text(
                          "No Data Found",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DirectorySource extends DataTableSource {
  List<AllEmployeesList> directoryList;
  BuildContext context;

  DirectorySource({this.directoryList, this.context});

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => directoryList.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(directoryList[index].id.toString())),
      DataCell(Text(directoryList[index].firstName + "," + directoryList[index].lastName)),
      DataCell(Text(directoryList[index].dept)),
      DataCell(Text(directoryList[index].desg)),
      DataCell(Text(directoryList[index].email == null ? "N/A" : directoryList[index].email)),
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TableIconTap(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => DirectoryDataById(
                  id: directoryList[index].id,
                ),
              );
            },
            icon: Icons.remove_red_eye_rounded,
            color: Palette.buttonBackgroundColor,
          ),
        ],
      ))
    ]);
  }
}
