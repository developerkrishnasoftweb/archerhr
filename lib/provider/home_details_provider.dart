import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/model/home_details_model.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';

class HomeEmployeeDataProvider with ChangeNotifier {
  HomeDetailsModel homeDetailsModel = HomeDetailsModel();
  bool loading = false;

  List<Holidays> _holidays = [];
  List<Tasks> _task = [];
  List<NewsList> _newsList = [];

  List<Holidays> get holidays => _holidays;
  List<Tasks> get task => _task;
  List<NewsList> get newsList => _newsList;

  void getHomeDashboardEmployeeData(context) async {
    loading = true;

    final response = await getDashboardEmployeeData();

    if (response.statusCode == 200) {
      homeDetailsModel = response.data;
      _holidays.addAll(response.data.holidays);
      _task.addAll(response.data.tasks);
      _newsList.addAll(response.data.newsList);
    } else {
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    _holidays = [];
    _task = [];
    _newsList = [];
  }
}
