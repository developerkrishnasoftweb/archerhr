import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/model/travel_list_data_model.dart';
import 'package:archerhr_mobile/provider/travel_data_provider.dart';
import 'package:archerhr_mobile/provider/travel_list_data_provider.dart';
import 'package:archerhr_mobile/screens/travel/widgets/domestic_travel.dart';
import 'package:archerhr_mobile/screens/travel/widgets/international_travel.dart';
import 'package:archerhr_mobile/screens/travel/widgets/update_domestic_travel.dart';
import 'package:archerhr_mobile/screens/travel/widgets/update_international_travel.dart';
import 'package:archerhr_mobile/screens/travel/widgets/watch_domestic_travel.dart';
import 'package:archerhr_mobile/screens/travel/widgets/watch_international_travel.dart';
import 'package:archerhr_mobile/screens/widgets/table_icon_tap.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TravelScreen extends StatefulWidget {
  const TravelScreen({Key key}) : super(key: key);

  @override
  _TravelScreenState createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  TravelDataProvider travelDataProvider;
  TravelListDataProvider travelListDataProvider;

  @override
  void initState() {
    super.initState();
    travelDataProvider = Provider.of<TravelDataProvider>(context, listen: false);
    travelDataProvider.getEmpTravelData(context);

    travelListDataProvider = Provider.of<TravelListDataProvider>(context, listen: false);
    travelListDataProvider.clear();
    travelListDataProvider.getEmpTravelData(context);
  }

  @override
  void dispose() {
    super.dispose();
    travelDataProvider.clear();
    travelListDataProvider.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.appBackground,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                      child: Consumer<TravelListDataProvider>(
                        builder: (context, provider, child) {
                          if (provider.loading) {
                            return const CircularProgressIndicator(
                              color: Palette.circularProgress,
                            );
                          }
                          if (provider.travelList.isNotEmpty) {
                            return PaginatedDataTable(
                              source: TravelSource(travelList: provider.travelList,context: context,travelDataProvider: travelDataProvider,travelListDataProvider: provider),
                              rowsPerPage: provider.travelList.length > 10 ? 10 : provider.travelList.length,
                              showFirstLastButtons: true,
                              headingRowHeight: 40,
                              columnSpacing: 10,
                              horizontalMargin: 10,
                              columns: const <DataColumn>[
                                DataColumn(label: Text('')),
                                DataColumn(
                                  label: Text('Status'),
                                ),
                                DataColumn(
                                  label: Text('Id'),
                                ),
                                DataColumn(
                                  label: Text('Type'),
                                ),
                                DataColumn(
                                  label: Text('Travel Date'),
                                ),
                                DataColumn(
                                  label: Text('Return Date'),
                                ),
                              ],
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
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: PopupMenuButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onSelected: (select) {
            if (select == 1) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => DomesticTravelScreen(
                  travelDataProvider: travelDataProvider,
                  travelListDataProvider: travelListDataProvider,
                ),
              );
            } else {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => InternationalTravelScreen(
                  travelDataProvider: travelDataProvider,
                  travelListDataProvider: travelListDataProvider,
                ),
              );
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () {},
                value: 1,
                child: Text(
                  'Domestic',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
              PopupMenuItem(
                onTap: () {},
                value: 2,
                child: Text(
                  'International',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ];
          },
        ),
        backgroundColor: Colors.green,
        onPressed: () {},
      ),
    );
  }
}

class TravelSource extends DataTableSource {
  List<TravelList> travelList;
  BuildContext context;
  TravelDataProvider travelDataProvider;
  TravelListDataProvider travelListDataProvider;

  TravelSource({this.travelList,this.context,this.travelDataProvider,this.travelListDataProvider});

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        travelList[index].statusId == 3 || travelList[index].statusId == 4
            ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TableIconTap(
              onTap: () {
                if (travelList[index].travelTypeId == 1) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => WatchDomesticTravelScreen(
                      id: travelList[index].id,
                      travelDataProvider: travelDataProvider,
                    ),
                  );
                } else {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => WatchInternationalTravelScreen(
                      id: travelList[index].id,
                      travelDataProvider: travelDataProvider,
                    ),
                  );
                }
              },
              icon: Icons.remove_red_eye_rounded,
              color: Palette.buttonBackgroundColor,
            ),
          ],
        )
            : Row(
          children: [
            TableIconTap(
              onTap: () {
                if (travelList[index].travelTypeId == 1) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => UpdateDomesticTravelScreen(
                        id: travelList[index].id,
                        travelDataProvider: travelDataProvider,
                        travelListDataProvider: travelListDataProvider),
                  );
                } else {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => UpdateInternationalTravelScreen(
                        id: travelList[index].id,
                        travelDataProvider: travelDataProvider,
                        travelListDataProvider: travelListDataProvider),
                  );
                }
              },
              icon: Icons.edit,
              color: Colors.orange,
            ),
            sizeBox5w,
            TableIconTap(
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return buildDoubleButtonPopupDialog(
                      context: context,
                      icon: Icons.error_outline_rounded,
                      mainText: "Are you sure ?",
                      text: "You would not be able to revert this !",
                      onPressed: () async {
                        final response = await deleteTravelId({'Id': '${travelList[index].id}'});
                        if (response.statusCode == 200) {
                          Navigator.pop(context);
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return buildSingleButtonPopupDialog(
                                    icon: Icons.check_circle_outline_rounded,
                                    mainText: "Deleted!",
                                    text: "Your Travel Successfully Deleted.",
                                    onPressed: () {
                                      Navigator.pop(context);
                                      travelListDataProvider.clear();
                                      travelListDataProvider.getEmpTravelData(context);
                                    });
                              });
                        } else if (response.statusCode == 404) {
                          unAuthenticationDialog(context);
                        }
                      },
                    );
                  },
                );
              },
              icon: Icons.delete_rounded,
              color: Colors.red,
            ),
          ],
        ),
      ),
      DataCell(travelList[index].statusId == 3
          ? approveStatus()
          : travelList[index].statusId == 4
          ? rejectStatus()
          : appliedStatus()),
      DataCell(Text('${travelList[index].id}')),
      DataCell(travelList[index].travelTypeId == 1 ? const Text("Dom") : const Text("Int")),
      DataCell(Text(travelList[index].travelDate)),
      DataCell(Text(travelList[index].returnDate)),

    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => travelList.length;

  @override
  int get selectedRowCount => 0;

}