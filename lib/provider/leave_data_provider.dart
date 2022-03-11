import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/model/leave_data_model.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';

class LeaveDataProvider with ChangeNotifier {
  LeaveData leaveData = LeaveData();
  bool loading = false;

  List<EmpLeaveList> _empList = [];
  List<LeaveCategory> _leaveCategoryList = [];
  List<LeaveTypes> _leaveTypeList = [];
  List<LeaveAvail> _leaveAvailList = [];

  List<EmpLeaveList> get empList => _empList;

  List<LeaveCategory> get leaveCategoryList => _leaveCategoryList;

  List<LeaveTypes> get leaveTypeList => _leaveTypeList;

  List<LeaveAvail> get leaveAvailList => _leaveAvailList;

  void getEmpLeaveData(context) async {
    loading = true;

    final response = await getLeaveData();
    if(response.statusCode == 200){
      _empList.addAll(response.data.empLeaveList);
      _leaveCategoryList.addAll(response.data.leaveCategory);
      _leaveTypeList.addAll(response.data.leaveTypes);
      _leaveAvailList.addAll(response.data.leaveAvail);
    }else{
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    _empList = [];
    _leaveCategoryList = [];
    _leaveTypeList = [];
    _leaveAvailList = [];
  }
}
