class PunchModel {
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

  PunchModel(
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

  PunchModel.fromJson(Map<String, dynamic> json) {
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