import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/model/dashboard_data_model.dart';
import 'package:archerhr_mobile/provider/dashboard_provider.dart';
import 'package:archerhr_mobile/screens/dashboard/view/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class MyTravelHomeScreen extends StatefulWidget {
  const MyTravelHomeScreen({Key key}) : super(key: key);

  @override
  _MyTravelHomeScreenState createState() => _MyTravelHomeScreenState();
}

class _MyTravelHomeScreenState extends State<MyTravelHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(
              selectedPage: 3,
            ),
          ),
        );
      },
      child: Container(
        height: 180.h,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0.h),
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
                    "My Travel",
                    style: TextStyle(
                      fontSize: 10.h,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              Consumer<DashboardProvider>(builder: (context, provider, child) {
                return Expanded(
                    child: SfCircularChart(
                        legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CircularSeries>[
                          DoughnutSeries<Travel, String>(
                              legendIconType: LegendIconType.rectangle,
                              enableTooltip: true,
                              //explodeAll: true,
                              //explode: true,
                              //explodeIndex: 0,
                              dataSource: provider.travelAvailability,
                              xValueMapper: (Travel data, _) => data.status,
                              yValueMapper: (Travel data, _) => data.count,
                              dataLabelSettings:
                              const DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
                        ]));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
