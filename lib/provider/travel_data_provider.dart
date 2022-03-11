import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/model/travel_data_model.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';

class TravelDataProvider with ChangeNotifier {
  TravelData travelData = TravelData();
  bool loading = false;

  List<TravelType> _travelTypeList = [];
  List<TravelMode> _travelModeList = [];
  List<CountryList> _travelCountryList = [];
  List<StateList> _travelStateList = [];
  List<Status> _travelStatusList = [];

  List<TravelType> get travelTypeList => _travelTypeList;

  List<TravelMode> get travelModeList => _travelModeList;

  List<CountryList> get travelCountryList => _travelCountryList;

  List<StateList> get travelStateList => _travelStateList;

  List<Status> get travelStatusList => _travelStatusList;

  getEmpTravelData(context) async {
    loading = true;

    final response = await getTravelData();

    if (response.statusCode == 200) {
      _travelTypeList.addAll(response.data.travelType);
      _travelModeList.addAll(response.data.travelMode);
      _travelCountryList.addAll(response.data.countryList);
      _travelStateList.addAll(response.data.stateList);
      _travelStatusList.addAll(response.data.status);
    }else {
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    _travelTypeList = [];
    _travelModeList = [];
    _travelCountryList = [];
    _travelStateList = [];
    _travelStatusList = [];
  }
}
