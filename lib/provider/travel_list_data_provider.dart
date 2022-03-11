import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/model/travel_list_data_model.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';

class TravelListDataProvider with ChangeNotifier {
  TravelListModel travelListModel = TravelListModel();
  bool loading = false;

  List<TravelList> _travelList = [];

  List<TravelList> get travelList => _travelList;

  getEmpTravelData(context) async {
    loading = true;

    final response = await getTravelListData();
    if (response.statusCode == 200) {
      _travelList.addAll(response.data.travelList);
    } else {
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    _travelList = [];
  }
}
