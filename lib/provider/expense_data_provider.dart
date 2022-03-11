import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/model/expense_data_model.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';

class ExpenseDataProvider with ChangeNotifier {
  ExpenseFieldModel expenseFieldModel;
  bool loading = false;

  List<ExpenseType> _expenseType = [];

  List<ExpenseType> get expenseType => _expenseType;

  getEmpExpenseData(context) async {
    loading = true;

    final response = await getExpenseFieldData();

    if (response.statusCode == 200) {
      _expenseType.addAll(response.data.expenseType);
    } else {
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    _expenseType = [];
  }
}
