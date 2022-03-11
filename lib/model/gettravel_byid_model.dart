class GetTravel {
  Travel travel;

  GetTravel({this.travel});

  GetTravel.fromJson(Map<String, dynamic> json) {
    travel =
    json['Travel'] != null ? Travel.fromJson(json['Travel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (travel != null) {
      data['Travel'] = travel.toJson();
    }
    return data;
  }
}

class Travel {
  int id;
  String appliedDate;
  String state;
  int stateId;
  String city;
  String travelDate;
  String returnDate;
  String departure;
  String arrival;
  String travelMode;
  int travelModeId;
  String status;
  int statusId;
  String country;
  int countryId;
  String travelType;
  String description;
  int travelTypeId;
  double advance;
  String employee;
  int employeeId;
  String apr1Employee;
  int approver1Id;
  String apr2Employee;
  int approver2Id;
  String tDApprover;
  int tDApproverId;
  String finApprover;
  int finApproverId;
  String ticket;
  String accomdation;
  String approverComments;
  String tDComments;
  String fINComments;
  String comments;
  String passportNo;
  String oldpassportNo;
  String passportIssuePlace;
  String passportIssueDate;
  String passportValidity;
  String createdBy;
  int modifiedBy;
  String createdDate;
  String modifiedDate;
  bool isRemoved;
  bool claimApplied;
  String expenseMaster;
  int expenseId;

  Travel(
      {this.id,
        this.appliedDate,
        this.state,
        this.stateId,
        this.city,
        this.travelDate,
        this.returnDate,
        this.departure,
        this.arrival,
        this.travelMode,
        this.travelModeId,
        this.status,
        this.statusId,
        this.country,
        this.countryId,
        this.travelType,
        this.description,
        this.travelTypeId,
        this.advance,
        this.employee,
        this.employeeId,
        this.apr1Employee,
        this.approver1Id,
        this.apr2Employee,
        this.approver2Id,
        this.tDApprover,
        this.tDApproverId,
        this.finApprover,
        this.finApproverId,
        this.ticket,
        this.accomdation,
        this.approverComments,
        this.tDComments,
        this.fINComments,
        this.comments,
        this.passportNo,
        this.oldpassportNo,
        this.passportIssuePlace,
        this.passportIssueDate,
        this.passportValidity,
        this.createdBy,
        this.modifiedBy,
        this.createdDate,
        this.modifiedDate,
        this.isRemoved,
        this.claimApplied,
        this.expenseMaster,
        this.expenseId});

  Travel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    appliedDate = json['AppliedDate'];
    state = json['State'];
    stateId = json['StateId'];
    city = json['City'];
    travelDate = json['TravelDate'];
    returnDate = json['ReturnDate'];
    departure = json['Departure'];
    arrival = json['Arrival'];
    travelMode = json['TravelMode'];
    travelModeId = json['TravelModeId'];
    status = json['Status'];
    statusId = json['StatusId'];
    country = json['Country'];
    countryId = json['CountryId'];
    travelType = json['TravelType'];
    description = json['Description'];
    travelTypeId = json['TravelTypeId'];
    advance = json['Advance'];
    employee = json['Employee'];
    employeeId = json['EmployeeId'];
    apr1Employee = json['Apr1Employee'];
    approver1Id = json['Approver1Id'];
    apr2Employee = json['Apr2Employee'];
    approver2Id = json['Approver2Id'];
    tDApprover = json['TDApprover'];
    tDApproverId = json['TDApproverId'];
    finApprover = json['FinApprover'];
    finApproverId = json['FinApproverId'];
    ticket = json['Ticket'];
    accomdation = json['Accomdation'];
    approverComments = json['ApproverComments'];
    tDComments = json['TDComments'];
    fINComments = json['FINComments'];
    comments = json['Comments'];
    passportNo = json['PassportNo'];
    oldpassportNo = json['OldpassportNo'];
    passportIssuePlace = json['PassportIssuePlace'];
    passportIssueDate = json['PassportIssueDate'];
    passportValidity = json['PassportValidity'];
    createdBy = json['CreatedBy'];
    modifiedBy = json['ModifiedBy'];
    createdDate = json['CreatedDate'];
    modifiedDate = json['ModifiedDate'];
    isRemoved = json['IsRemoved'];
    claimApplied = json['ClaimApplied'];
    expenseMaster = json['ExpenseMaster'];
    expenseId = json['ExpenseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['AppliedDate'] = appliedDate;
    data['State'] = state;
    data['StateId'] = stateId;
    data['City'] = city;
    data['TravelDate'] = travelDate;
    data['ReturnDate'] = returnDate;
    data['Departure'] = departure;
    data['Arrival'] = arrival;
    data['TravelMode'] = travelMode;
    data['TravelModeId'] = travelModeId;
    data['Status'] = status;
    data['StatusId'] = statusId;
    data['Country'] = country;
    data['CountryId'] = countryId;
    data['TravelType'] = travelType;
    data['Description'] = description;
    data['TravelTypeId'] = travelTypeId;
    data['Advance'] = advance;
    data['Employee'] = employee;
    data['EmployeeId'] = employeeId;
    data['Apr1Employee'] = apr1Employee;
    data['Approver1Id'] = approver1Id;
    data['Apr2Employee'] = apr2Employee;
    data['Approver2Id'] = approver2Id;
    data['TDApprover'] = tDApprover;
    data['TDApproverId'] = tDApproverId;
    data['FinApprover'] = finApprover;
    data['FinApproverId'] = finApproverId;
    data['Ticket'] = ticket;
    data['Accomdation'] = accomdation;
    data['ApproverComments'] = approverComments;
    data['TDComments'] = tDComments;
    data['FINComments'] = fINComments;
    data['Comments'] = comments;
    data['PassportNo'] = passportNo;
    data['OldpassportNo'] = oldpassportNo;
    data['PassportIssuePlace'] = passportIssuePlace;
    data['PassportIssueDate'] = passportIssueDate;
    data['PassportValidity'] = passportValidity;
    data['CreatedBy'] = createdBy;
    data['ModifiedBy'] = modifiedBy;
    data['CreatedDate'] = createdDate;
    data['ModifiedDate'] = modifiedDate;
    data['IsRemoved'] = isRemoved;
    data['ClaimApplied'] = claimApplied;
    data['ExpenseMaster'] = expenseMaster;
    data['ExpenseId'] = expenseId;
    return data;
  }
}