import 'package:archerhr_mobile/const/const_class.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyAttendanceHomeScreen extends StatefulWidget {
  const MyAttendanceHomeScreen({Key key}) : super(key: key);

  @override
  _MyAttendanceHomeScreenState createState() => _MyAttendanceHomeScreenState();
}

class _MyAttendanceHomeScreenState extends State<MyAttendanceHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 180.h,
        width: 180.w,
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
                    "My Attendance",
                    style: TextStyle(
                      fontSize: 10.h,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: SfCartesianChart(
                    backgroundColor: Colors.white,
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      LineSeries<SalesData, String>(
                          dataSource: [
                            SalesData('Mo', 5, Colors.orange),
                            SalesData('Tu', 15, Colors.orange),
                            SalesData('We', 10, Colors.orange),
                            SalesData('Th', 20, Colors.orange),
                            SalesData('Fr', 25, Colors.orange),
                            SalesData('Sa', 7, Colors.orange),
                            SalesData('Su', 7, Colors.orange),
                          ],
                          // Bind the color for all the data points from the data source
                          pointColorMapper: (SalesData sales, _) => sales.segmentColor,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          markerSettings:
                          MarkerSettings(isVisible: true, color: Colors.orange, height: 4.h, width: 4.w))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
