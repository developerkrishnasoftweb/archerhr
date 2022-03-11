class TravelApprovalModel {
  List<MyAprTravelList> myAprTravelList;

  TravelApprovalModel({this.myAprTravelList});

  TravelApprovalModel.fromJson(Map<String, dynamic> json) {
    if (json['MyAprTravelList'] != null) {
      myAprTravelList = <MyAprTravelList>[];
      json['MyAprTravelList'].forEach((v) {
        myAprTravelList.add(MyAprTravelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (myAprTravelList != null) {
      data['MyAprTravelList'] =
          myAprTravelList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyAprTravelList {
  int id;
  String firstName;
  String lastName;
  String empCode;
  String travelDate;
  String returnDate;
  String status;
  String travelType;
  double advance;
  String approverComments;
  int statusId;
  int travelTypeId;

  MyAprTravelList(
      {this.id,
        this.firstName,
        this.lastName,
        this.empCode,
        this.travelDate,
        this.returnDate,
        this.status,
        this.travelType,
        this.advance,
        this.approverComments,
        this.statusId,
        this.travelTypeId});

  MyAprTravelList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    empCode = json['EmpCode'];
    travelDate = json['TravelDate'];
    returnDate = json['ReturnDate'];
    status = json['Status'];
    travelType = json['TravelType'];
    advance = json['Advance'];
    approverComments = json['ApproverComments'];
    statusId = json['StatusId'];
    travelTypeId = json['TravelTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['EmpCode'] = empCode;
    data['TravelDate'] = travelDate;
    data['ReturnDate'] = returnDate;
    data['Status'] = status;
    data['TravelType'] = travelType;
    data['Advance'] = advance;
    data['ApproverComments'] = approverComments;
    data['StatusId'] = statusId;
    data['TravelTypeId'] = travelTypeId;
    return data;
  }
}