
import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/model/directory_data_byid_model.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';

class GetDirectoryByIdProvider with ChangeNotifier {
  DirectoryByIdModel directoryByIdModel = DirectoryByIdModel();
  bool loading = true;

  EmployeeDetails _employeeDetails;
  RepMgr _repMgr;
  EmployeeDetails get employeeDetails => _employeeDetails;
  RepMgr get repMgr => _repMgr;

  Future<void> getDirectoryListByIdData(context, id) async {
    loading = true;
    final response = await getDirectoryDataById({'Id': '$id'});

    if (response.statusCode == 200) {
      directoryByIdModel = response.data;
      _employeeDetails = response.data.employeeDetails;
      _repMgr = response.data.repMgr;
    }else {
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    directoryByIdModel = DirectoryByIdModel();
  }
}