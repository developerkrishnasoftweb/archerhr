import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/get_travel_provider.dart';
import 'package:archerhr_mobile/provider/travel_data_provider.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InternationalTravelApprovalScreen extends StatefulWidget {
  InternationalTravelApprovalScreen({Key key,this.id}) : super(key: key);
  int id;

  @override
  _InternationalTravelApprovalScreenState createState() => _InternationalTravelApprovalScreenState();
}

class _InternationalTravelApprovalScreenState extends State<InternationalTravelApprovalScreen> {
  var statusList = ["Approve","Reject"];
  String status;
  int stateDropdownValue;
  int countryDropdownValue;

  TravelDataProvider travelDataProvider;
  GetTravelProvider getTravelProvider;
  TextEditingController dateOfIssueController = TextEditingController();
  TextEditingController dateValidTillController = TextEditingController();
  TextEditingController travelDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController returningToController = TextEditingController();
  TextEditingController ticketController = TextEditingController();
  TextEditingController accommodationController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  TextEditingController purposeOfVisitController = TextEditingController();
  TextEditingController passportNoController = TextEditingController();
  TextEditingController oldPassportNoController = TextEditingController();
  TextEditingController placeOfIssueController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    travelDataProvider = Provider.of<TravelDataProvider>(context, listen: false);
    travelDataProvider.getEmpTravelData(context);
    getTravelProvider = Provider.of<GetTravelProvider>(context, listen: false);
    getTravelById();
  }

  getTravelById() async {
    await getTravelProvider.getTravelData(context,widget.id);
    String travelDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(getTravelProvider.getTravel.travel.travelDate));
    String returnDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(getTravelProvider.getTravel.travel.returnDate));
    String passportIssueDate =
    DateFormat('dd-MM-yyyy').format(DateTime.parse(getTravelProvider.getTravel.travel.passportIssueDate));
    String passportValidityDate =
    DateFormat('dd-MM-yyyy').format(DateTime.parse(getTravelProvider.getTravel.travel.passportValidity));

    travelDateController.text = travelDate;
    returnDateController.text = returnDate;
    fromController.text = getTravelProvider.getTravel.travel.departure;
    returningToController.text = getTravelProvider.getTravel.travel.arrival;
    dateOfIssueController.text = passportIssueDate;
    dateValidTillController.text = passportValidityDate;

    cityController.text = getTravelProvider.getTravel.travel.city;
    advanceController.text = '${getTravelProvider.getTravel.travel.advance}';
    purposeOfVisitController.text = getTravelProvider.getTravel.travel.comments;
    passportNoController.text = getTravelProvider.getTravel.travel.passportNo;
    oldPassportNoController.text = getTravelProvider.getTravel.travel.oldpassportNo;
    placeOfIssueController.text = getTravelProvider.getTravel.travel.passportIssuePlace;
    ticketController.text = getTravelProvider.getTravel.travel.ticket;
    accommodationController.text = getTravelProvider.getTravel.travel.accomdation;

    stateDropdownValue = getTravelProvider.getTravel.travel.stateId;
    countryDropdownValue = getTravelProvider.getTravel.travel.countryId;
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
                                        label: "Traveling Country",
                                      ),
                                      DropdownButton<int>(
                                        isExpanded: true,
                                        icon: const SizedBox(),
                                        hint: const Text("Select Country"),
                                        value: countryDropdownValue,
                                        underline: const SizedBox(),
                                        items: travelDataProvider.travelCountryList.map((countryList) {
                                          return DropdownMenuItem(
                                            child: Text(countryList.name),
                                            value: countryList.id,
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
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "PASSPORT DETAILS",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                            sizeBox20h,
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TitleText(label: "Passport No"),
                                      Input(
                                        controller: passportNoController,
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
                                      const TitleText(label: "Old Passport No"),
                                      Input(
                                        controller: oldPassportNoController,
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
                                      const TitleText(label: "Place Of Issue"),
                                      Input(
                                        controller: placeOfIssueController,
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
                                      const TitleText(label: "Date Of Issue"),
                                      Input(
                                        controller: dateOfIssueController,
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
                                      const TitleText(label: "Valid Till"),
                                      Input(
                                        controller: dateValidTillController,
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
                                        label: "Approve/Reject",
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        child: DropdownButton(
                                          isExpanded: true,
                                          icon: const Visibility(
                                            visible: false,
                                            child: Icon(Icons.arrow_drop_down_outlined),
                                          ),
                                          value: status,
                                          underline: const SizedBox(),
                                          hint: const Text("Select"),
                                          items: statusList.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      items,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              status = newValue;
                                            });
                                          },
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
                                        label: "Reason",
                                      ),
                                      Input(
                                        controller: commentsController,
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
                            Center(
                              child: Container(
                                width: 150.w,
                                decoration: BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "UPDATE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ),
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

