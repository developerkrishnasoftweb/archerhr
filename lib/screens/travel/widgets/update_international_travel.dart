import 'dart:developer';

import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/get_travel_provider.dart';
import 'package:archerhr_mobile/provider/travel_data_provider.dart';
import 'package:archerhr_mobile/provider/travel_list_data_provider.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateInternationalTravelScreen extends StatefulWidget {
  UpdateInternationalTravelScreen({Key key, this.travelDataProvider, this.id,this.travelListDataProvider}) : super(key: key);
  TravelDataProvider travelDataProvider;
  int id;
  TravelListDataProvider travelListDataProvider;

  @override
  _UpdateInternationalTravelScreenState createState() => _UpdateInternationalTravelScreenState();
}

class _UpdateInternationalTravelScreenState extends State<UpdateInternationalTravelScreen> {
  int stateDropdownValue;
  int countryDropdownValue;
  int modeDropdownValue;
  var chooseTicketRequired = ["Yes", "No"];
  String ticketRequiredDropdownValue;
  var chooseAccommodation = ["Yes", "No"];
  String accommodationDropdownValue;

  bool isLoading = false;
  TravelDataProvider travelDataProvider;
  GetTravelProvider getTravelProvider;
  TravelListDataProvider travelListDataProvider;
  TextEditingController dateOfIssueController = TextEditingController();
  TextEditingController dateValidTillController = TextEditingController();
  TextEditingController travelDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController returningToController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  TextEditingController purposeOfVisitController = TextEditingController();
  TextEditingController passportNoController = TextEditingController();
  TextEditingController oldPassportNoController = TextEditingController();
  TextEditingController placeOfIssueController = TextEditingController();

  dateTap(BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      String formattedDate = DateFormat('MM-dd-yyyy').format(picked);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    travelDataProvider = widget.travelDataProvider;
    travelListDataProvider = widget.travelListDataProvider;
    getTravelProvider = Provider.of<GetTravelProvider>(context, listen: false);
    getTravelById();
  }

  getTravelById() async {
    await getTravelProvider.getTravelData(context,widget.id);
    String travelDate = DateFormat('MM-dd-yyyy').format(DateTime.parse(getTravelProvider.getTravel.travel.travelDate));
    String returnDate = DateFormat('MM-dd-yyyy').format(DateTime.parse(getTravelProvider.getTravel.travel.returnDate));
    String passportIssueDate =
        DateFormat('MM-dd-yyyy').format(DateTime.parse(getTravelProvider.getTravel.travel.passportIssueDate));
    String passportValidityDate =
        DateFormat('MM-dd-yyyy').format(DateTime.parse(getTravelProvider.getTravel.travel.passportValidity));

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

    //modeDropdownValue = getTravelProvider.getTravel.travel.travelModeId;
    stateDropdownValue = getTravelProvider.getTravel.travel.stateId;
    countryDropdownValue = getTravelProvider.getTravel.travel.countryId;
  }

  @override
  void dispose() {
    super.dispose();
    getTravelProvider.clear();
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
                    "Edit International Travel",
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
                                        onTap: () => dateTap(context, travelDateController),
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
                                        onTap: () => dateTap(context, returnDateController),
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
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        child: DropdownButton<int>(
                                          isExpanded: true,
                                          icon: const SizedBox(),
                                          value: countryDropdownValue,
                                          hint: const Text("Select Country"),
                                          underline: const SizedBox(),
                                          items: travelDataProvider.travelCountryList.map((countryList) {
                                            return DropdownMenuItem(
                                              child: Text(countryList.name),
                                              value: countryList.id,
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              countryDropdownValue = newValue;
                                            });
                                          },
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
                                        label: "Traveling State",
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        child: DropdownButton<int>(
                                          isExpanded: true,
                                          icon: const SizedBox(),
                                          value: stateDropdownValue,
                                          hint: const Text("Select State"),
                                          underline: const SizedBox(),
                                          items: travelDataProvider.travelStateList
                                              .where((state) => state.countryId == countryDropdownValue)
                                              .map((stateList) {
                                            return DropdownMenuItem(
                                              child: Text(stateList.name),
                                              value: stateList.id,
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              stateDropdownValue = newValue;
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
                                        label: "City",
                                      ),
                                      Input(
                                        controller: cityController,
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
                                        onTap: () => dateTap(context, fromController),
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
                                        onTap: () => dateTap(context, returningToController),
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
                                          hint: const Text("Choose Ticket Required"),
                                          value: ticketRequiredDropdownValue,
                                          underline: const SizedBox(),
                                          items: chooseTicketRequired.map((String items) {
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
                                              ticketRequiredDropdownValue = newValue;
                                            });
                                          },
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
                                          value: accommodationDropdownValue,
                                          underline: const SizedBox(),
                                          hint: const Text("Choose Accommodation"),
                                          items: chooseAccommodation.map((String items) {
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
                                              accommodationDropdownValue = newValue;
                                            });
                                          },
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
                                        onTap: () => dateTap(context, dateOfIssueController),
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
                                        onTap: () => dateTap(context, dateValidTillController),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizeBox30h,
                            Container(
                              width: 150.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.r),
                                color: Palette.buttonBackgroundColor,
                              ),
                              child: TextButton(
                                onPressed: _updateTravel,
                                child: isLoading == false
                                    ? const Text(
                                        'UPDATE TRAVEL',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : const CircularProgressIndicator(color: Colors.white),
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

  _updateTravel() async {
    if (travelDateController.text.isNotEmpty &&
        returnDateController.text.isNotEmpty &&
        countryDropdownValue != null &&
        stateDropdownValue != null &&
        cityController.text.isNotEmpty &&
        fromController.text.isNotEmpty &&
        returningToController.text.isNotEmpty &&
        ticketRequiredDropdownValue.isNotEmpty &&
        accommodationDropdownValue.isNotEmpty &&
        advanceController.text.isNotEmpty &&
        purposeOfVisitController.text.isNotEmpty &&
        passportNoController.text.isNotEmpty &&
        oldPassportNoController.text.isNotEmpty &&
        placeOfIssueController.text.isNotEmpty &&
        dateOfIssueController.text.isNotEmpty &&
        dateValidTillController.text.isNotEmpty) {

      // unFocus keyboard
      Utils.unFocus(context);
      isLoading = true;

      final travelJson = {
        "Id": widget.id,
        "TravelTypeId": 2,
        "Traveldate": travelDateController.text,
        "ReturnDate": returnDateController.text,
        "CountryId": countryDropdownValue,
        "StateId": stateDropdownValue,
        "City": cityController.text,
        "Departure": fromController.text,
        "Arrival": returningToController.text,
        "Ticket": ticketRequiredDropdownValue,
        "Accomdation": accommodationDropdownValue,
        "Advance": advanceController.text,
        "Comments": purposeOfVisitController.text,
        "PassportNo": passportNoController.text,
        "OldpassportNo": oldPassportNoController.text,
        "PassportIssuePlace": placeOfIssueController.text,
        "PassportIssueDate": dateOfIssueController.text,
        "PassportValidity": dateValidTillController.text,
      };

      final response = await saveInternationalTravel(travelJson);

      if (response.statusCode == 200) {
        Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return buildSingleButtonPopupDialog(
                  context: context,
                  icon: Icons.check_circle_outline_rounded,
                  mainText: "Updated",
                  text: "Travel Update Successfully.",
                  onPressed: () {
                    Navigator.pop(context);
                    travelListDataProvider.clear();
                    travelListDataProvider.getEmpTravelData(context);
                  });
            });
      } else if (response.statusCode == 404) {
        Navigator.pop(context);
        unAuthenticationDialog(context);
      } else {
        log(response.reasonPhrase);
      }
      isLoading = false;

    } else {
      Utils.showToast("Please enter detail");
    }
  }
}
