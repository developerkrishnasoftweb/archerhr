class ExpenseApproval {
  List<MyExpenseAprlReq> myExpenseAprlReq;

  ExpenseApproval({this.myExpenseAprlReq});

  ExpenseApproval.fromJson(Map<String, dynamic> json) {
    if (json['MyExpenseAprlReq'] != null) {
      myExpenseAprlReq = <MyExpenseAprlReq>[];
      json['MyExpenseAprlReq'].forEach((v) {
        myExpenseAprlReq.add(MyExpenseAprlReq.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (myExpenseAprlReq != null) {
      data['MyExpenseAprlReq'] =
          myExpenseAprlReq.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyExpenseAprlReq {
  int id;
  String appliedDate;
  String status;
  String firstName;
  String lastName;

  MyExpenseAprlReq(
      {this.id, this.appliedDate, this.status, this.firstName, this.lastName});

  MyExpenseAprlReq.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    appliedDate = json['AppliedDate'];
    status = json['Status'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['AppliedDate'] = appliedDate;
    data['Status'] = status;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    return data;
  }
}