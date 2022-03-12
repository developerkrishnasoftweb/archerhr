import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/model/directory_list_data_model.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';

class GetDirectoryListProvider with ChangeNotifier {
  DirectoryListModel directoryListModel = DirectoryListModel();
  bool loading = true;

  List<AllEmployeesList> _allEmployeesList = [];

  List<AllEmployeesList> get allEmployeesList => _allEmployeesList;

  Future<void> getDirectoryData(context) async {
    loading = true;

    final response = await directoryListData();

    if (response.statusCode == 200) {
      directoryListModel = response.data;
      _allEmployeesList = response.data.allEmployeesList;


    }else {
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    _allEmployeesList = [];
  }
}
