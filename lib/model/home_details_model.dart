import 'package:archerhr_mobile/model/dashboard_data_model.dart';

class HomeDetailsModel {
  List<Projects> projects;
  List<Tasks> tasks;
  List<Attendance> attendance;
  List<Holidays> holidays;
  List<Leaves> leaves;
  List<LeaveAvailabity> leaveAvailabity;
  List<Expense> expense;
  List<Travel> travel;
  List<NewsList> newsList;
  List<GetEmpApproval> getEmpApproval;
  String lastMonth;
  List<String> empBirthdays;

  HomeDetailsModel(
      {this.projects,
        this.tasks,
        this.attendance,
        this.holidays,
        this.leaves,
        this.leaveAvailabity,
        this.expense,
        this.travel,
        this.newsList,
        this.getEmpApproval,
        this.lastMonth,
        this.empBirthdays});

  HomeDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['Projects'] != null) {
      projects = <Projects>[];
      json['Projects'].forEach((v) {
        projects.add(Projects.fromJson(v));
      });
    }
    if (json['Tasks'] != null) {
      tasks = <Tasks>[];
      json['Tasks'].forEach((v) {
        tasks.add(Tasks.fromJson(v));
      });
    }
    if (json['Attendance'] != null) {
      attendance = <Attendance>[];
      json['Attendance'].forEach((v) {
        attendance.add(Attendance.fromJson(v));
      });
    }
    if (json['Holidays'] != null) {
      holidays = <Holidays>[];
      json['Holidays'].forEach((v) {
        holidays.add(Holidays.fromJson(v));
      });
    }
    if (json['Leaves'] != null) {
      leaves = <Leaves>[];
      json['Leaves'].forEach((v) {
        leaves.add(Leaves.fromJson(v));
      });
    }
    if (json['LeaveAvailabity'] != null) {
      leaveAvailabity = <LeaveAvailabity>[];
      json['LeaveAvailabity'].forEach((v) {
        leaveAvailabity.add(LeaveAvailabity.fromJson(v));
      });
    }
    if (json['Expense'] != null) {
      expense = <Expense>[];
      json['Expense'].forEach((v) {
        expense.add(Expense.fromJson(v));
      });
    }
    if (json['Travel'] != null) {
      travel = <Travel>[];
      json['Travel'].forEach((v) {
        travel.add(Travel.fromJson(v));
      });
    }
    if (json['NewsList'] != null) {
      newsList = <NewsList>[];
      json['NewsList'].forEach((v) {
        newsList.add(NewsList.fromJson(v));
      });
    }
    if (json['GetEmpApproval'] != null) {
      getEmpApproval = <GetEmpApproval>[];
      json['GetEmpApproval'].forEach((v) {
        getEmpApproval.add(GetEmpApproval.fromJson(v));
      });
    }
    lastMonth = json['LastMonth'];
    /*if (json['EmpBirthdays'] != null) {
      empBirthdays = <Null>[];
      json['EmpBirthdays'].forEach((v) {
        empBirthdays.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (projects != null) {
      data['Projects'] = projects.map((v) => v.toJson()).toList();
    }
    if (tasks != null) {
      data['Tasks'] = tasks.map((v) => v.toJson()).toList();
    }
    if (attendance != null) {
      data['Attendance'] = attendance.map((v) => v.toJson()).toList();
    }
    if (holidays != null) {
      data['Holidays'] = holidays.map((v) => v.toJson()).toList();
    }
    if (leaves != null) {
      data['Leaves'] = leaves.map((v) => v.toJson()).toList();
    }
    if (leaveAvailabity != null) {
      data['LeaveAvailabity'] =
          leaveAvailabity.map((v) => v.toJson()).toList();
    }
    if (expense != null) {
      data['Expense'] = expense.map((v) => v.toJson()).toList();
    }
    if (travel != null) {
      data['Travel'] = travel.map((v) => v.toJson()).toList();
    }
    if (newsList != null) {
      data['NewsList'] = newsList.map((v) => v.toJson()).toList();
    }
    if (getEmpApproval != null) {
      data['GetEmpApproval'] =
          getEmpApproval.map((v) => v.toJson()).toList();
    }
    data['LastMonth'] = lastMonth;
    /*if (this.empBirthdays != null) {
      data['EmpBirthdays'] = this.empBirthdays!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Projects {
  int id;
  String appliedDate;
  String approvedDate;
  String employee;
  int employeeId;
  String apr1Employee;
  int approver1Id;
  String apr2Employee;
  int approver2Id;
  String description;
  String from;
  String to;
  String status;
  int statusId;
  String leaveType;
  int leaveTypeId;
  String modifiedDate;
  String approverComments;
  String hRComments;
  String leaveCategory;
  int leaveCategoryId;
  bool isRemoved;

  Projects(
      {this.id,
        this.appliedDate,
        this.approvedDate,
        this.employee,
        this.employeeId,
        this.apr1Employee,
        this.approver1Id,
        this.apr2Employee,
        this.approver2Id,
        this.description,
        this.from,
        this.to,
        this.status,
        this.statusId,
        this.leaveType,
        this.leaveTypeId,
        this.modifiedDate,
        this.approverComments,
        this.hRComments,
        this.leaveCategory,
        this.leaveCategoryId,
        this.isRemoved});

  Projects.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    appliedDate = json['AppliedDate'];
    approvedDate = json['ApprovedDate'];
    employee = json['Employee'];
    employeeId = json['EmployeeId'];
    apr1Employee = json['Apr1Employee'];
    approver1Id = json['Approver1Id'];
    apr2Employee = json['Apr2Employee'];
    approver2Id = json['Approver2Id'];
    description = json['Description'];
    from = json['From'];
    to = json['To'];
    status = json['Status'];
    statusId = json['StatusId'];
    leaveType = json['LeaveType'];
    leaveTypeId = json['LeaveTypeId'];
    modifiedDate = json['ModifiedDate'];
    approverComments = json['ApproverComments'];
    hRComments = json['HRComments'];
    leaveCategory = json['LeaveCategory'];
    leaveCategoryId = json['LeaveCategoryId'];
    isRemoved = json['IsRemoved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['AppliedDate'] = appliedDate;
    data['ApprovedDate'] = approvedDate;
    data['Employee'] = employee;
    data['EmployeeId'] = employeeId;
    data['Apr1Employee'] = apr1Employee;
    data['Approver1Id'] = approver1Id;
    data['Apr2Employee'] = apr2Employee;
    data['Approver2Id'] = approver2Id;
    data['Description'] = description;
    data['From'] = from;
    data['To'] = to;
    data['Status'] = status;
    data['StatusId'] = statusId;
    data['LeaveType'] = leaveType;
    data['LeaveTypeId'] = leaveTypeId;
    data['ModifiedDate'] = modifiedDate;
    data['ApproverComments'] = approverComments;
    data['HRComments'] = hRComments;
    data['LeaveCategory'] = leaveCategory;
    data['LeaveCategoryId'] = leaveCategoryId;
    data['IsRemoved'] = isRemoved;
    return data;
  }
}

class Tasks {
  int id;
  String projectName;
  String title;
  String targetDate;

  Tasks({this.id, this.projectName, this.title, this.targetDate});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    projectName = json['ProjectName'];
    title = json['Title'];
    targetDate = json['TargetDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['ProjectName'] = projectName;
    data['Title'] = title;
    data['TargetDate'] = targetDate;
    return data;
  }
}

class Attendance {
  int id;
  String employee;
  int employeeId;
  int userId;
  int year;
  int month;
  String start;
  String end;
  String startCity;
  String startLatit;
  String startLongt;
  String endCity;
  String endLatit;
  String endLongt;

  Attendance(
      {this.id,
        this.employee,
        this.employeeId,
        this.userId,
        this.year,
        this.month,
        this.start,
        this.end,
        this.startCity,
        this.startLatit,
        this.startLongt,
        this.endCity,
        this.endLatit,
        this.endLongt});

  Attendance.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    employee = json['Employee'];
    employeeId = json['EmployeeId'];
    userId = json['UserId'];
    year = json['Year'];
    month = json['Month'];
    start = json['Start'];
    end = json['End'];
    startCity = json['start_city'];
    startLatit = json['start_latit'];
    startLongt = json['start_longt'];
    endCity = json['end_city'];
    endLatit = json['end_latit'];
    endLongt = json['end_longt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Employee'] = employee;
    data['EmployeeId'] = employeeId;
    data['UserId'] = userId;
    data['Year'] = year;
    data['Month'] = month;
    data['Start'] = start;
    data['End'] = end;
    data['start_city'] = startCity;
    data['start_latit'] = startLatit;
    data['start_longt'] = startLongt;
    data['end_city'] = endCity;
    data['end_latit'] = endLatit;
    data['end_longt'] = endLongt;
    return data;
  }
}

class Holidays {
  String holiday;
  String holidayDate;
  String description;
  String region;

  Holidays({this.holiday, this.holidayDate, this.description, this.region});

  Holidays.fromJson(Map<String, dynamic> json) {
    holiday = json['Holiday'];
    holidayDate = json['HolidayDate'];
    description = json['Description'];
    region = json['Region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Holiday'] = holiday;
    data['HolidayDate'] = holidayDate;
    data['Description'] = description;
    data['Region'] = region;
    return data;
  }
}

class LeaveAvailabity {
  String name;
  double leaveConsumed;
  double leaveTotal;

  LeaveAvailabity({this.name, this.leaveConsumed, this.leaveTotal});

  LeaveAvailabity.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    leaveConsumed = json['LeaveConsumed'];
    leaveTotal = json['LeaveTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['LeaveConsumed'] = leaveConsumed;
    data['LeaveTotal'] = leaveTotal;
    return data;
  }
}

class Expense {
  int month;
  double amount;

  Expense({this.month, this.amount});

  Expense.fromJson(Map<String, dynamic> json) {
    month = json['Month'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Month'] = month;
    data['Amount'] = amount;
    return data;
  }
}

class Travel {
  String status;
  int count;

  Travel({this.status, this.count});

  Travel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    count = json['Count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Count'] = count;
    return data;
  }
}

class NewsList {
  int id;
  String title;
  String description;
  String postFrom;
  String postTo;
  String fileUrl;
  String createdEmp;
  int createdBy;
  String modifiedEmp;
  int modifiedBy;
  String createdDate;
  String modifiedDate;
  bool isRemoved;

  NewsList(
      {this.id,
        this.title,
        this.description,
        this.postFrom,
        this.postTo,
        this.fileUrl,
        this.createdEmp,
        this.createdBy,
        this.modifiedEmp,
        this.modifiedBy,
        this.createdDate,
        this.modifiedDate,
        this.isRemoved});

  NewsList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    description = json['Description'];
    postFrom = json['PostFrom'];
    postTo = json['PostTo'];
    fileUrl = json['FileUrl'];
    createdEmp = json['CreatedEmp'];
    createdBy = json['CreatedBy'];
    modifiedEmp = json['ModifiedEmp'];
    modifiedBy = json['ModifiedBy'];
    createdDate = json['CreatedDate'];
    modifiedDate = json['ModifiedDate'];
    isRemoved = json['IsRemoved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Title'] = title;
    data['Description'] = description;
    data['PostFrom'] = postFrom;
    data['PostTo'] = postTo;
    data['FileUrl'] = fileUrl;
    data['CreatedEmp'] = createdEmp;
    data['CreatedBy'] = createdBy;
    data['ModifiedEmp'] = modifiedEmp;
    data['ModifiedBy'] = modifiedBy;
    data['CreatedDate'] = createdDate;
    data['ModifiedDate'] = modifiedDate;
    data['IsRemoved'] = isRemoved;
    return data;
  }
}

class GetEmpApproval {
  int id;
  String empFName;
  String empLName;
  int typeId;
  String typeName;
  String appliedDate;

  GetEmpApproval(
      {this.id,
        this.empFName,
        this.empLName,
        this.typeId,
        this.typeName,
        this.appliedDate});

  GetEmpApproval.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    empFName = json['EmpFName'];
    empLName = json['EmpLName'];
    typeId = json['TypeId'];
    typeName = json['TypeName'];
    appliedDate = json['AppliedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['EmpFName'] = empFName;
    data['EmpLName'] = empLName;
    data['TypeId'] = typeId;
    data['TypeName'] = typeName;
    data['AppliedDate'] = appliedDate;
    return data;
  }
}