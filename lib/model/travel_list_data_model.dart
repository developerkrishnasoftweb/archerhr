class TravelListModel {
  List<TravelList> travelList;

  TravelListModel({this.travelList});

  TravelListModel.fromJson(Map<String, dynamic> json) {
    if (json['TravelList'] != null) {
      travelList = <TravelList>[];
      json['TravelList'].forEach((v) {
        travelList.add(TravelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (travelList != null) {
      data['TravelList'] = travelList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelList {
  int id;
  String travelDate;
  String returnDate;
  String status;
  String travelType;
  double advance;
  String approverComments;
  int statusId;
  int travelTypeId;

  TravelList(
      {this.id,
        this.travelDate,
        this.returnDate,
        this.status,
        this.travelType,
        this.advance,
        this.approverComments,
        this.statusId,
        this.travelTypeId});

  TravelList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
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