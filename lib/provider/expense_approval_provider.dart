import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/model/expense_approval_model.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';

class ExpenseApprovalProvider with ChangeNotifier {
  ExpenseApproval expenseApproval = ExpenseApproval();
  bool loading = false;

  List<MyExpenseAprlReq> _myExpenseApproval = [];

  List<MyExpenseAprlReq> get myExpenseApproval => _myExpenseApproval;

  void getExpenseApproval(context) async {
    loading = true;

    final response = await getExpenseApprovalData();
    if(response.statusCode == 200){
       expenseApproval = response.data;
      _myExpenseApproval.addAll(response.data.myExpenseAprlReq);
    }else{
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    _myExpenseApproval = [];
  }
}