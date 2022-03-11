import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/model/travel_approval_model.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';

class TravelApprovalProvider with ChangeNotifier {
  TravelApprovalModel travelApproval = TravelApprovalModel();
  bool loading = false;

  List<MyAprTravelList> _myTravelApproval = [];

  List<MyAprTravelList> get myTravelApproval => _myTravelApproval;

  void getTravelApproval(context) async {
    loading = true;

    final response = await getTravelApprovalData();
    if (response.statusCode == 200) {
      travelApproval = response.data;
      _myTravelApproval.addAll(response.data.myAprTravelList);
    } else {
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    _myTravelApproval = [];
  }
}
