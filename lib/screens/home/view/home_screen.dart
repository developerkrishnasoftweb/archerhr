import 'package:archerhr_mobile/const/const_class.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/model/dashboard_data_model.dart';
import 'package:archerhr_mobile/provider/dashboard_provider.dart';
import 'package:archerhr_mobile/screens/dashboard/view/dashboard_screen.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DashboardProvider dashboardProvider;

  @override
  void initState() {
    super.initState();
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    dashboardProvider.clear();
    dashboardProvider.getDashboardGraphData(context);
  }

  @override
  void dispose() {
    super.dispose();
    dashboardProvider.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(
                          selectedPage: 1,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 180.h,
                    width: 180.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.home,
                                size: 15,
                              ),
                              sizeBox5w,
                              Text(
                                "My Leaves",
                                style: TextStyle(
                                  fontSize: 10.h,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                        sizeBox30h,
                        Consumer<DashboardProvider>(builder: (context, provider, child) {
                          if (provider.loading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Palette.circularProgress,
                              ),
                            );
                          }
                          if (provider.leaveAvailability.isNotEmpty) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Casual Leaves ${provider.leaveAvailability[0].leaveConsumed}/${int.parse(provider.leaveAvailability[0].leaveTotal.toString().split(".").first)}",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                                  child: LinearPercentIndicator(
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: 8.h,
                                    percent:
                                        provider.leaveAvailability[0].leaveConsumed / provider.leaveAvailability[0].leaveTotal,
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.blue[400],
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                                sizeBox10h,
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Sick Leaves ${provider.leaveAvailability[1].leaveConsumed}/${int.parse(provider.leaveAvailability[1].leaveTotal.toString().split(".").first)}",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                                  child: LinearPercentIndicator(
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: 8.h,
                                    percent:
                                        provider.leaveAvailability[1].leaveConsumed / provider.leaveAvailability[1].leaveTotal,
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.orange[400],
                                    backgroundColor: Colors.grey[300],
                                  ),
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
              ),
              sizeBox10w,
              Expanded(
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
              ),
            ],
          ),
          sizeBox10h,
          GestureDetector(
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
                      return Expanded(
                          child: SfCircularChart(
                              legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <CircularSeries>[
                            DoughnutSeries<Expense, String>(
                                legendIconType: LegendIconType.rectangle,
                                enableTooltip: true,
                                //explodeAll: true,
                                //explode: true,
                                //explodeIndex: 0,
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
                          ]));
                    }),
                  ],
                ),
              ),
            ),
          ),
          sizeBox10h,
          GestureDetector(
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
          ),
          sizeBox10h,
          Card(
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
                          "Birthday Wishes",
                          style: TextStyle(
                            fontSize: 10.h,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, right: 10.w),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 35.w,
                                      height: 35.h,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(237, 237, 237, 1),
                                      ),
                                    ),
                                    sizeBox10w,
                                    Expanded(
                                      child: Container(
                                        width: size.width,
                                        height: 35.h,
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(237, 237, 237, 1),
                                            borderRadius: BorderRadius.circular(10.r)),
                                      ),
                                    )
                                  ],
                                ),
                                sizeBox5h,
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
