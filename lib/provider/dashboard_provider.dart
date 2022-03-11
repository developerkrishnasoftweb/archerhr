import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/model/dashboard_data_model.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';

class DashboardProvider with ChangeNotifier {
  DashboardData dashboardData = DashboardData();
  bool loading = false;

  List<LeaveAvailabity> _leaveAvailability = [];
  List<Expense> _expenseAvailability = [];
  List<Travel> _travelAvailability = [];

  List<LeaveAvailabity> get leaveAvailability => _leaveAvailability;

  List<Expense> get expenseAvailability => _expenseAvailability;

  List<Travel> get travelAvailability => _travelAvailability;

  void getDashboardGraphData(context) async {
    loading = true;

    final response = await getDashboardData();

    if (response.statusCode == 200) {
      dashboardData = response.data;
      _leaveAvailability.addAll(response.data.leaveAvailabity);
      _expenseAvailability.addAll(response.data.expense);
      _travelAvailability.addAll(response.data.travel);
    } else {
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    _leaveAvailability = [];
    _expenseAvailability = [];
    _travelAvailability = [];
  }
}
