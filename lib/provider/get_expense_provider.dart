import 'package:archerhr_mobile/model/getexpense_byid_model.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';

class GetExpenseProvider with ChangeNotifier {
  GetEmpExpenseModel getEmpExpenseModel = GetEmpExpenseModel();
  bool loading = true;
  Expense _expense;

  List<ExpenseList> _expenseList = [];
  List<ExpenseType> _expenseType = [];
  List<ExpenseTypeList> _expenseTypeList = [];
  double _totalAmount = 0;

  double get totalAmount => _totalAmount;

  Expense get expense => _expense;

  List<ExpenseList> get expenseList => _expenseList;

  List<ExpenseType> get expenseType => _expenseType;

  List<ExpenseTypeList> get expenseTypeList => _expenseTypeList;

  void setState() => notifyListeners();

  Future<void> getExpenseData(context, id) async {
    loading = true;
    final response = await getExpenseDataById({'Id': '$id'});

    if (response.statusCode == 200) {
      getEmpExpenseModel = response.data;
      _expense = response.data.expense;
      _expenseList.addAll(response.data.expenseList);
      _expenseType.addAll(response.data.expenseType);
      _expenseTypeList.addAll(response.data.expenseTypeList);

      _totalAmount = _expenseList.map((amount) => amount.amount).fold(0, (previousValue, amount) => previousValue + amount);
    } else {
      // log("Response Provider StatusCode : ${response.statusCode}");
      /*    showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return buildSingleButtonPopupDialog(
                icon: Icons.warning_amber_rounded,
                iconColor: Colors.red,
                mainText: "Unauthorized!",
                text: "Authentication failed,please login again",
                onPressed: () async {
                  await kSharedPreferences.remove("Cookie");
                  await kSharedPreferences.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                  final result = await FlutterRestart.restartApp();
                  print("result : $result");
                });
          });*/
    }

    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    getEmpExpenseModel = GetEmpExpenseModel();
    _expenseList = [];
    _expenseType = [];
    _expenseTypeList = [];
    _totalAmount = 0;
  }
}
