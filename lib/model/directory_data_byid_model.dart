class DirectoryByIdModel {
  EmployeeDetails employeeDetails;
  List<String> resignationReason;
  RepMgr repMgr;

  DirectoryByIdModel(
      {this.employeeDetails, this.resignationReason, this.repMgr});

  DirectoryByIdModel.fromJson(Map<String, dynamic> json) {
    employeeDetails = json['EmployeeDetails'] != null
        ? EmployeeDetails.fromJson(json['EmployeeDetails'])
        : null;
   /* if (json['ResignationReason'] != null) {
      resignationReason = <Null>[];
      json['ResignationReason'].forEach((v) {
        resignationReason.add(Null.fromJson(v));
      });
    }*/
    repMgr =
    json['RepMgr'] != null ? RepMgr.fromJson(json['RepMgr']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employeeDetails != null) {
      data['EmployeeDetails'] = employeeDetails.toJson();
    }
    /*if (resignationReason != null) {
      data['ResignationReason'] =
          resignationReason.map((v) => v.toJson()).toList();
    }*/
    if (repMgr != null) {
      data['RepMgr'] = repMgr.toJson();
    }
    return data;
  }
}

class EmployeeDetails {
  int employeeId;
  String firstName;
  String lastName;
  String dOJ;
  String dOB;
  String branch;
  String bU;
  String dept;
  String desg;
  String empId;
  String photoName;
  String priEmail;
  String mobileno;
  String aboutMe;

  EmployeeDetails(
      {this.employeeId,
        this.firstName,
        this.lastName,
        this.dOJ,
        this.dOB,
        this.branch,
        this.bU,
        this.dept,
        this.desg,
        this.empId,
        this.photoName,
        this.priEmail,
        this.mobileno,
        this.aboutMe});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    employeeId = json['EmployeeId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    dOJ = json['DOJ'];
    dOB = json['DOB'];
    branch = json['Branch'];
    bU = json['BU'];
    dept = json['Dept'];
    desg = json['Desg'];
    empId = json['EmpId'];
    photoName = json['PhotoName'];
    priEmail = json['Pri_email'];
    mobileno = json['Mobileno'];
    aboutMe = json['AboutMe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmployeeId'] = employeeId;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['DOJ'] = dOJ;
    data['DOB'] = dOB;
    data['Branch'] = branch;
    data['BU'] = bU;
    data['Dept'] = dept;
    data['Desg'] = desg;
    data['EmpId'] = empId;
    data['PhotoName'] = photoName;
    data['Pri_email'] = priEmail;
    data['Mobileno'] = mobileno;
    data['AboutMe'] = aboutMe;
    return data;
  }
}

class RepMgr {
  String firstName;
  String lastName;
  String empId;

  RepMgr({this.firstName, this.lastName, this.empId});

  RepMgr.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    lastName = json['LastName'];
    empId = json['EmpId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['EmpId'] = empId;
    return data;
  }
}