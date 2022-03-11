import 'package:archerhr_mobile/model/getleave_byid_model.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';

class GetLeaveProvider with ChangeNotifier {
  GetLeave getLeave = GetLeave();
  bool loading = true;

  void setState() => notifyListeners();

 Future<void> getLeaveData(context,id) async {
    loading = true;

    final response = await getLeaveInfoById({
      'Id' : '$id'
    });
    if(response.statusCode == 200){
      getLeave = response.data;
    }

    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
     getLeave = GetLeave();
  }
}
