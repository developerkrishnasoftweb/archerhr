import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/profile_provider.dart';
import 'package:archerhr_mobile/screens/widgets/table_icon_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankProfileScreen extends StatefulWidget {
  BankProfileScreen({Key key, this.profileProvider}) : super(key: key);
  ProfileProvider profileProvider;

  @override
  _BankProfileScreenState createState() => _BankProfileScreenState();
}

class _BankProfileScreenState extends State<BankProfileScreen> {
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
        title: const Text("Bank Details"),
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
                      label: Text('AC No'),
                    ),
                    DataColumn(
                      label: Text('Bank'),
                    ),
                    DataColumn(
                      label: Text('Branch'),
                    ),
                    DataColumn(
                      label: Text('IFSC'),
                    ),
                    DataColumn(
                      label: Text('AC Type'),
                    ),
                    DataColumn(
                      label: Text('AC for'),
                    ),
                  ],
                  rows: profileProvider.employeeBankList
                      .map(
                        (e) => DataRow(cells: [
                      DataCell(Text(e.aCNo1)),
                      DataCell(Text(e.bankName)),
                      DataCell(Text(e.branch)),
                      DataCell(Text(e.iFSC)),
                      DataCell(Text(e.aCType)),
                      DataCell(Text(e.oPType)),
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
