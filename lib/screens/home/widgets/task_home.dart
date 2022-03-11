import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/home_details_provider.dart';
import 'package:archerhr_mobile/screens/home/widgets/source_class.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TaskHomeScreen extends StatefulWidget {
  const TaskHomeScreen({Key key}) : super(key: key);

  @override
  _TaskHomeScreenState createState() => _TaskHomeScreenState();
}

class _TaskHomeScreenState extends State<TaskHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SizedBox(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.home,
                    size: 15,
                  ),
                  sizeBox5w,
                  Text(
                    "My Tasks",
                    style: TextStyle(
                      fontSize: 10.h,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Consumer<HomeEmployeeDataProvider>(builder: (context, provider, child) {
                if (provider.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Palette.circularProgress,
                    ),
                  );
                }
                if (provider.task.isNotEmpty) {
                  return PaginatedDataTable(
                    source: TaskSource(tasksList: provider.task, context: context),
                    rowsPerPage: provider.task.length > 5 ? 5 : provider.task.length,
                    showFirstLastButtons: true,
                    headingRowHeight: 40,
                    columnSpacing: 40,
                    horizontalMargin: 10,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('Id'),
                      ),
                      DataColumn(
                        label: Text('Title'),
                      ),
                      DataColumn(
                        label: Text('TargetDate'),
                      ),
                      DataColumn(
                        label: Text('Action'),
                      ),
                    ],
                  );
                } else {
                  return Text(
                    "No Data Found",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
