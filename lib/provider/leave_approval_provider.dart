import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/model/leave_approval_model.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';

class LeaveApprovalProvider with ChangeNotifier {
  LeaveApproval leaveApproval = LeaveApproval();
  bool loading = false;

  List<MyAprLeaveList> _myLeaveApproval = [];

  List<MyAprLeaveList> get myLeaveApproval => _myLeaveApproval;

  void getLeaveApproval(context) async {
    loading = true;

    final response = await getLeaveApprovalData();
    if (response.statusCode == 200) {
      leaveApproval = response.data;
      _myLeaveApproval.addAll(response.data.myAprLeaveList);
    } else {
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    _myLeaveApproval = [];
  }
}
