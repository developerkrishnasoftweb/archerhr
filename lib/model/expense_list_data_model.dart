class MyExpenseListModel {
  List<MyExpenseList> myExpenseList;

  MyExpenseListModel({this.myExpenseList});

  MyExpenseListModel.fromJson(Map<String, dynamic> json) {
    if (json['MyExpenseList'] != null) {
      myExpenseList = <MyExpenseList>[];
      json['MyExpenseList'].forEach((v) {
        myExpenseList.add(MyExpenseList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (myExpenseList != null) {
      data['MyExpenseList'] =
          myExpenseList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyExpenseList {
  int id;
  String appliedDate;
  String status;
  int statusId;

  MyExpenseList({this.id, this.appliedDate, this.status, this.statusId});

  MyExpenseList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    appliedDate = json['AppliedDate'];
    status = json['Status'];
    statusId = json['StatusId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['AppliedDate'] = appliedDate;
    data['Status'] = status;
    data['StatusId'] = statusId;
    return data;
  }
}




