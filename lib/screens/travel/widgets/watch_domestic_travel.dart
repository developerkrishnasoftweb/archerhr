import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/get_travel_provider.dart';
import 'package:archerhr_mobile/provider/travel_data_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WatchDomesticTravelScreen extends StatefulWidget {
  WatchDomesticTravelScreen({Key key, this.id, this.travelDataProvider}) : super(key: key);
  TravelDataProvider travelDataProvider;
  int id;

  @override
  _WatchDomesticTravelScreenState createState() => _WatchDomesticTravelScreenState();
}

class _WatchDomesticTravelScreenState extends State<WatchDomesticTravelScreen> {
  TravelDataProvider travelDataProvider;
  GetTravelProvider getTravelProvider;

  int stateDropdownValue;
  int modeDropdownValue;
  TextEditingController travelDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController modeTravelController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController returningToController = TextEditingController();
  TextEditingController ticketController = TextEditingController();
  TextEditingController accommodationController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  TextEditingController purposeOfVisitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    travelDataProvider = widget.travelDataProvider;
    getTravelProvider = Provider.of<GetTravelProvider>(context, listen: false);
    getTravelById();
  }

  @override
  void dispose() {
    super.dispose();
    getTravelProvider.clear();
  }

  getTravelById() async {
    await getTravelProvider.getTravelData(context,widget.id);
    String travelDate = DateFormat('MM-dd-yyyy').format(DateTime.parse(getTravelProvider.getTravel.travel.travelDate));
    String returnDate = DateFormat('MM-dd-yyyy').format(DateTime.parse(getTravelProvider.getTravel.travel.returnDate));

    travelDateController.text = travelDate;
    returnDateController.text = returnDate;
    fromController.text = getTravelProvider.getTravel.travel.departure;
    returningToController.text = getTravelProvider.getTravel.travel.arrival;

    cityController.text = getTravelProvider.getTravel.travel.city;
    advanceController.text = '${getTravelProvider.getTravel.travel.advance}';
    purposeOfVisitController.text = getTravelProvider.getTravel.travel.comments;

    modeDropdownValue = getTravelProvider.getTravel.travel.travelModeId;
    stateDropdownValue = getTravelProvider.getTravel.travel.stateId;

    ticketController.text = getTravelProvider.getTravel.travel.ticket;
    accommodationController.text = getTravelProvider.getTravel.travel.accomdation;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetTravelProvider>(
      builder: (context, provider, child) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25.r),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    "View Domestic Travel",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (provider.loading)
                      const CircularProgressIndicator()
                    else
                      Form(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(
                                        label: "Travel Date",
                                      ),
                                      Input(
                                        controller: travelDateController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                sizeBox10w,
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(
                                        label: "Return Date",
                                      ),
                                      Input(
                                        controller: returnDateController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizeBox20h,
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(
                                        label: "Mode of Travel",
                                      ),
                                      DropdownButton<int>(
                                        isExpanded: true,
                                        icon: const SizedBox(),
                                        hint: const Text("Choose Mode"),
                                        value: modeDropdownValue,
                                        underline: const SizedBox(),
                                        items: travelDataProvider.travelModeList.map((modeType) {
                                          return DropdownMenuItem(
                                            child: Text(modeType.name,style: TextStyle(color: Colors.grey[800])),
                                            value: modeType.id,
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizeBox20h,
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(
                                        label: "State",
                                      ),
                                      DropdownButton<int>(
                                        isExpanded: true,
                                        icon: const SizedBox(),
                                        value: stateDropdownValue,
                                        hint: const Text("Select State"),
                                        underline: const SizedBox(),
                                        items: travelDataProvider.travelStateList
                                            .where((state) => state.countryId == 101)
                                            .map((stateList) {
                                          return DropdownMenuItem(
                                            child: Text(stateList.name,style: TextStyle(color: Colors.grey[800]),),
                                            value: stateList.id,
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                sizeBox10w,
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(
                                        label: "City",
                                      ),
                                      Input(
                                        controller: cityController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizeBox20h,
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(label: "From"),
                                      Input(
                                        controller: fromController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                sizeBox10w,
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(label: "Returning To"),
                                      Input(
                                        controller: returningToController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizeBox20h,
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(
                                        label: "Ticket Required",
                                      ),
                                      Input(
                                        controller: ticketController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizeBox20h,
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(label: "Accommodation"),
                                      Input(
                                        controller: accommodationController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizeBox20h,
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(label: "Advance Amount"),
                                      Input(
                                        controller: advanceController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                sizeBox10w,
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(
                                        label: "Purpose of visit",
                                      ),
                                      Input(
                                        controller: purposeOfVisitController,
                                        readOnly: true,
                                        inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
