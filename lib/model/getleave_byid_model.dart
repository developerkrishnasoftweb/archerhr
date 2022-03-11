class GetLeave {
  int id;
  String categoryName;
  String type;
  String description;
  int leaveTypeId;
  String from;
  String to;
  String statusName;
  String approverComments;
  String hRComments;

  GetLeave(
      {this.id,
        this.categoryName,
        this.type,
        this.description,
        this.leaveTypeId,
        this.from,
        this.to,
        this.statusName,
        this.approverComments,
        this.hRComments});

  GetLeave.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    categoryName = json['CategoryName'];
    type = json['Type'];
    description = json['Description'];
    leaveTypeId = json['LeaveTypeId'];
    from = json['From'];
    to = json['To'];
    statusName = json['StatusName'];
    approverComments = json['ApproverComments'];
    hRComments = json['HRComments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['CategoryName'] = categoryName;
    data['Type'] = type;
    data['Description'] = description;
    data['LeaveTypeId'] = leaveTypeId;
    data['From'] = from;
    data['To'] = to;
    data['StatusName'] = statusName;
    data['ApproverComments'] = approverComments;
    data['HRComments'] = hRComments;
    return data;
  }
}