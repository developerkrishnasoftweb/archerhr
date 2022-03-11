import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/get_travel_provider.dart';
import 'package:archerhr_mobile/provider/travel_data_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DomesticTravelApprovalScreen extends StatefulWidget {
  DomesticTravelApprovalScreen({Key key, this.id}) : super(key: key);
  int id;

  @override
  _DomesticTravelApprovalScreenState createState() => _DomesticTravelApprovalScreenState();
}

class _DomesticTravelApprovalScreenState extends State<DomesticTravelApprovalScreen> {
  var statusList = ["Approve", "Reject"];
  String status;
  bool isLoading = false;
  GetTravelProvider getTravelProvider;
  int stateDropdownValue;
  int modeDropdownValue;
  TravelDataProvider travelDataProvider;
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
  TextEditingController commentsController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    travelDataProvider = Provider.of<TravelDataProvider>(context, listen: false);
    travelDataProvider.getEmpTravelData(context);
    getTravelProvider = Provider.of<GetTravelProvider>(context, listen: false);
    getTravelById();
  }

  getTravelById() async {
    await getTravelProvider.getTravelData(context, widget.id);
    String travelDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(getTravelProvider.getTravel.travel.travelDate));
    String returnDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(getTravelProvider.getTravel.travel.returnDate));

    travelDateController.text = travelDate;
    returnDateController.text = returnDate;
    fromController.text = getTravelProvider.getTravel.travel.departure;
    returningToController.text = getTravelProvider.getTravel.travel.arrival;

    cityController.text = getTravelProvider.getTravel.travel.city;
    advanceController.text = '${getTravelProvider.getTravel.travel.advance}';
    purposeOfVisitController.text = getTravelProvider.getTravel.travel.comments;

    modeDropdownValue = getTravelProvider.getTravel.travel.travelModeId;
    stateDropdownValue = getTravelProvider.getTravel.travel.stateId;

    print(modeDropdownValue);

    ticketController.text = getTravelProvider.getTravel.travel.ticket;
    accommodationController.text = getTravelProvider.getTravel.travel.accomdation;
  }

  @override
  void dispose() {
    super.dispose();
    getTravelProvider.clear();
    travelDataProvider.clear();
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
                    "Approve Domestic Travel",
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
                                            child: Text(modeType.name),
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
                                            child: Text(stateList.name),
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
                            sizeBox20h,
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(
                                        label: "Reason",
                                      ),
                                      Input(
                                        controller: reasonController,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizeBox30h,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(7.r),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "APPROVE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                sizeBox10w,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(7.r),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "REJECT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
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

/* _statusApproveDomesticTravel() async {
    Utils.unFocus(context);
    isLoading = true;

    final statusJson = {"ApproverComments": reasonController.text, "Id": widget.id, "StatusId": 3};

    final response = await statusTravelUpdate(body: statusJson);

    if (response.statusCode == 200) {
      Navigator.pop(context);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return buildSingleButtonPopupDialog(
                context: context,
                icon: Icons.check_circle_outline_rounded,
                mainText: "Approved",
                text: "Travel Successfully Approved.",
                onPressed: () {
                  Navigator.pop(context);
                  travelDataProvider.clear();
                  travelDataProvider.getEmpTravelData(context);
                });
          });
    } else if (response.statusCode == 404) {
      Navigator.pop(context);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return buildSingleButtonPopupDialog(
                icon: Icons.warning_amber_rounded,
                iconColor: Colors.red,
                mainText: "Unauthenticated!",
                text: "Authentication failed,please login again",
                onPressed: () {
                  kSharedPreferences.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                  );
                });
          });
    } else {
      log(response.reasonPhrase);
    }
    isLoading = false;
  }*/
}
