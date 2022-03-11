class DirectoryListModel {
  List<AllEmployeesList> allEmployeesList;

  DirectoryListModel({this.allEmployeesList});

  DirectoryListModel.fromJson(Map<String, dynamic> json) {
    if (json['AllEmployeesList'] != null) {
      allEmployeesList = <AllEmployeesList>[];
      json['AllEmployeesList'].forEach((v) {
        allEmployeesList.add(AllEmployeesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allEmployeesList != null) {
      data['AllEmployeesList'] =
          allEmployeesList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllEmployeesList {
  int id;
  String empId;
  String firstName;
  String lastName;
  String middleName;
  String dept;
  String desg;
  String email;
  String photoName;
  int statusId;

  AllEmployeesList(
      {this.id,
        this.empId,
        this.firstName,
        this.lastName,
        this.middleName,
        this.dept,
        this.desg,
        this.email,
        this.photoName,
        this.statusId});

  AllEmployeesList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    empId = json['EmpId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    middleName = json['MiddleName'];
    dept = json['Dept'];
    desg = json['Desg'];
    email = json['Email'];
    photoName = json['PhotoName'];
    statusId = json['StatusId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['EmpId'] = empId;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['MiddleName'] = middleName;
    data['Dept'] = dept;
    data['Desg'] = desg;
    data['Email'] = email;
    data['PhotoName'] = photoName;
    data['StatusId'] = statusId;
    return data;
  }
}