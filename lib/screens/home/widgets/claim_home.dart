import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/model/dashboard_data_model.dart';
import 'package:archerhr_mobile/provider/dashboard_provider.dart';
import 'package:archerhr_mobile/screens/dashboard/view/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyClaimHomeScreen extends StatefulWidget {
  const MyClaimHomeScreen({Key key}) : super(key: key);

  @override
  _MyClaimHomeScreenState createState() => _MyClaimHomeScreenState();
}

class _MyClaimHomeScreenState extends State<MyClaimHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(
              selectedPage: 2,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          height: 180.h,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 5.w, 0.h),
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
                      "My Claim",
                      style: TextStyle(
                        fontSize: 10.h,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                Consumer<DashboardProvider>(builder: (context, provider, child) {
                  if (provider.loading) {
                    return Text(
                      "No Data Found",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: SfCircularChart(
                          legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <CircularSeries>[
                            DoughnutSeries<Expense, String>(
                                legendIconType: LegendIconType.rectangle,
                                enableTooltip: true,
                                dataSource: provider.expenseAvailability,
                                xValueMapper: (Expense data, _) => data.month == 1
                                    ? "January"
                                    : data.month == 2
                                        ? "February"
                                        : data.month == 3
                                            ? "March"
                                            : data.month == 4
                                                ? "April"
                                                : data.month == 5
                                                    ? "May"
                                                    : data.month == 6
                                                        ? "June"
                                                        : data.month == 7
                                                            ? "July"
                                                            : data.month == 8
                                                                ? "August"
                                                                : data.month == 9
                                                                    ? "September"
                                                                    : data.month == 10
                                                                        ? "October"
                                                                        : data.month == 11
                                                                            ? "November"
                                                                            : "December",
                                yValueMapper: (Expense data, _) => int.parse(data.amount.toString().split(".")[0]),
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
                          ]),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
