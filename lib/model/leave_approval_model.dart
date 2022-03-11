class LeaveApproval {
  List<MyAprLeaveList> myAprLeaveList;

  LeaveApproval({this.myAprLeaveList});

  LeaveApproval.fromJson(Map<String, dynamic> json) {
    if (json['MyAprLeaveList'] != null) {
      myAprLeaveList = <MyAprLeaveList>[];
      json['MyAprLeaveList'].forEach((v) {
        myAprLeaveList.add(MyAprLeaveList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (myAprLeaveList != null) {
      data['MyAprLeaveList'] =
          myAprLeaveList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyAprLeaveList {
  int id;
  String category;
  String status;
  String leaveType;
  String from;
  String to;
  String empId;
  String description;
  String firstName;
  String lastName;

  MyAprLeaveList(
      {this.id,
        this.category,
        this.status,
        this.leaveType,
        this.from,
        this.to,
        this.empId,
        this.description,
        this.firstName,
        this.lastName});

  MyAprLeaveList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category = json['Category'];
    status = json['Status'];
    leaveType = json['LeaveType'];
    from = json['From'];
    to = json['To'];
    empId = json['EmpId'];
    description = json['Description'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Category'] = category;
    data['Status'] = status;
    data['LeaveType'] = leaveType;
    data['From'] = from;
    data['To'] = to;
    data['EmpId'] = empId;
    data['Description'] = description;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    return data;
  }
}