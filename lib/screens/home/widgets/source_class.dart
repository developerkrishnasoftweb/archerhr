import 'package:archerhr_mobile/model/home_details_model.dart';
import 'package:archerhr_mobile/screens/widgets/table_icon_tap.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskSource extends DataTableSource {
  List<Tasks> tasksList;
  BuildContext context;

  TaskSource({this.tasksList, this.context});

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(tasksList[index].id.toString())),
      DataCell(Text(tasksList[index].title)),
      DataCell(Text(DateFormat('MMM dd, yyyy').format(DateTime.parse(tasksList[index].targetDate)))),
      DataCell(
        Center(
          child: TableIconTap(
            onTap: () {},
            icon: Icons.remove_red_eye_rounded,
            color: Palette.buttonBackgroundColor,
          ),
        ),
      )
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tasksList.length;

  @override
  int get selectedRowCount => 0;
}
