class LeaveData {
  List<LeaveCategory> leaveCategory;
  List<LeaveAvail> leaveAvail;
  List<LeaveTypes> leaveTypes;
  List<HLeaveTypes> hLeaveTypes;
  List<EmpLeaveList> empLeaveList;

  LeaveData(
      {this.leaveCategory,
        this.leaveAvail,
        this.leaveTypes,
        this.hLeaveTypes,
        this.empLeaveList});

  LeaveData.fromJson(Map<String, dynamic> json) {
    if (json['leavecategory'] != null) {
      leaveCategory = <LeaveCategory>[];
      json['leavecategory'].forEach((v) {
        leaveCategory.add(LeaveCategory.fromJson(v));
      });
    }
    if (json['leaveavail'] != null) {
      leaveAvail = <LeaveAvail>[];
      json['leaveavail'].forEach((v) {
        leaveAvail.add(LeaveAvail.fromJson(v));
      });
    }
    if (json['leavetypes'] != null) {
      leaveTypes = <LeaveTypes>[];
      json['leavetypes'].forEach((v) {
        leaveTypes.add(LeaveTypes.fromJson(v));
      });
    }
    if (json['Hleavetypes'] != null) {
      hLeaveTypes = <HLeaveTypes>[];
      json['Hleavetypes'].forEach((v) {
        hLeaveTypes.add(HLeaveTypes.fromJson(v));
      });
    }
    if (json['EmpLeaveList'] != null) {
      empLeaveList = <EmpLeaveList>[];
      json['EmpLeaveList'].forEach((v) {
        empLeaveList.add(EmpLeaveList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaveCategory != null) {
      data['leavecategory'] =
          leaveCategory.map((v) => v.toJson()).toList();
    }
    if (leaveAvail != null) {
      data['leaveavail'] = leaveAvail.map((v) => v.toJson()).toList();
    }
    if (leaveTypes != null) {
      data['leavetypes'] = leaveTypes.map((v) => v.toJson()).toList();
    }
    if (hLeaveTypes != null) {
      data['Hleavetypes'] = hLeaveTypes.map((v) => v.toJson()).toList();
    }
    if (empLeaveList != null) {
      data['EmpLeaveList'] = empLeaveList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveCategory {
  int id;
  String name;
  bool isRemoved;

  LeaveCategory({this.id, this.name, this.isRemoved});

  LeaveCategory.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    isRemoved = json['IsRemoved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['IsRemoved'] = isRemoved;
    return data;
  }
}

class LeaveAvail {
  String description;
  int leaveTypeId;
  String leaveType;
  String startDate;
  String endDate;
  double carryForward;
  double leaveTotal;
  double leaveConsumed;
  int min;
  int max;
  double leaveBalance;

  LeaveAvail(
      {this.description,
        this.leaveTypeId,
        this.leaveType,
        this.startDate,
        this.endDate,
        this.carryForward,
        this.leaveTotal,
        this.leaveConsumed,
        this.min,
        this.max,
        this.leaveBalance});

  LeaveAvail.fromJson(Map<String, dynamic> json) {
    description = json['Description'];
    leaveTypeId = json['LeaveTypeId'];
    leaveType = json['LeaveType'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    carryForward = json['CarryForward'];
    leaveTotal = json['LeaveTotal'];
    leaveConsumed = json['LeaveConsumed'];
    min = json['Min'];
    max = json['Max'];
    leaveBalance = json['LeaveBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Description'] = description;
    data['LeaveTypeId'] = leaveTypeId;
    data['LeaveType'] = leaveType;
    data['StartDate'] = startDate;
    data['EndDate'] = endDate;
    data['CarryForward'] = carryForward;
    data['LeaveTotal'] = leaveTotal;
    data['LeaveConsumed'] = leaveConsumed;
    data['Min'] = min;
    data['Max'] = max;
    data['LeaveBalance'] = leaveBalance;
    return data;
  }
}

class LeaveTypes {
  int leaveTypeId;
  String name;
  int min;
  int max;
  double leaveBalance;

  LeaveTypes(
      {this.leaveTypeId, this.name, this.min, this.max, this.leaveBalance});

  LeaveTypes.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['LeaveTypeId'];
    name = json['Name'];
    min = json['Min'];
    max = json['Max'];
    leaveBalance = json['LeaveBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LeaveTypeId'] = leaveTypeId;
    data['Name'] = name;
    data['Min'] = min;
    data['Max'] = max;
    data['LeaveBalance'] = leaveBalance;
    return data;
  }
}

class HLeaveTypes {
  int leaveTypeId;
  String leaveType;
  int min;
  int max;
  double leaveBalance;

  HLeaveTypes(
      {this.leaveTypeId,
        this.leaveType,
        this.min,
        this.max,
        this.leaveBalance});

  HLeaveTypes.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['LeaveTypeId'];
    leaveType = json['LeaveType'];
    min = json['Min'];
    max = json['Max'];
    leaveBalance = json['LeaveBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LeaveTypeId'] = leaveTypeId;
    data['LeaveType'] = leaveType;
    data['Min'] = min;
    data['Max'] = max;
    data['LeaveBalance'] = leaveBalance;
    return data;
  }
}

class EmpLeaveList {
  int id;
  String from;
  String to;
  String status;
  String leaveType;
  String description;
  int leaveTypeId;
  int statusId;
  String category;
  int leaveCategoryId;

  EmpLeaveList(
      {this.id,
        this.from,
        this.to,
        this.status,
        this.leaveType,
        this.description,
        this.leaveTypeId,
        this.statusId,
        this.category,
        this.leaveCategoryId});

  EmpLeaveList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    from = json['From'];
    to = json['To'];
    status = json['Status'];
    leaveType = json['LeaveType'];
    description = json['Description'];
    leaveTypeId = json['LeaveTypeId'];
    statusId = json['StatusId'];
    category = json['Category'];
    leaveCategoryId = json['LeaveCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['From'] = from;
    data['To'] = to;
    data['Status'] = status;
    data['LeaveType'] = leaveType;
    data['Description'] = description;
    data['LeaveTypeId'] = leaveTypeId;
    data['StatusId'] = statusId;
    data['Category'] = category;
    data['LeaveCategoryId'] = leaveCategoryId;
    return data;
  }
}