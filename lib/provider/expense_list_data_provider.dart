import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/model/expense_list_data_model.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';

class ExpenseListDataProvider with ChangeNotifier {
  MyExpenseListModel myExpenseListModel;
  bool loading = false;

  List<MyExpenseList> _expenseList = [];

  List<MyExpenseList> get expenseList => _expenseList;

  getEmpExpenseData(context) async {
    loading = true;

    final response = await getExpenseListData();

    if (response.statusCode == 200) {
      _expenseList.addAll(response.data.myExpenseList);
    } else {
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    _expenseList = [];
  }
}
