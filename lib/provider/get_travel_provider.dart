
import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/model/gettravel_byid_model.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';

class GetTravelProvider with ChangeNotifier {
  GetTravel getTravel = GetTravel();
  bool loading = true;

  void setState() => notifyListeners();

  Future<void> getTravelData(context,id) async {
    loading = true;
    final response = await getTravelInfoById({
      'Id' : '$id'
    });

    if (response.statusCode == 200) {
      getTravel = response.data;
    }else{
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    getTravel = GetTravel();
  }

}