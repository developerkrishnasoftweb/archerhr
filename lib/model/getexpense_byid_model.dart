class GetEmpExpenseModel {
  Expense expense;
  List<ExpenseList> expenseList;
  List<ExpenseType> expenseType;
  List<ExpenseTypeList> expenseTypeList;
  List<String> currency;

  GetEmpExpenseModel(
      {this.expense,
        this.expenseList,
        this.expenseType,
        this.expenseTypeList,
        this.currency});

  GetEmpExpenseModel.fromJson(Map<String, dynamic> json) {
    expense =
    json['Expense'] != null ? Expense.fromJson(json['Expense']) : null;
    if (json['ExpenseList'] != null) {
      expenseList = <ExpenseList>[];
      json['ExpenseList'].forEach((v) {
        expenseList.add(ExpenseList.fromJson(v));
      });
    }
    if (json['ExpenseType'] != null) {
      expenseType = <ExpenseType>[];
      json['ExpenseType'].forEach((v) {
        expenseType.add(ExpenseType.fromJson(v));
      });
    }
    if (json['ExpenseTypeList'] != null) {
      expenseTypeList = <ExpenseTypeList>[];
      json['ExpenseTypeList'].forEach((v) {
        expenseTypeList.add(ExpenseTypeList.fromJson(v));
      });
    }
   /* if (json['Currency'] != null) {
      currency = <Null>[];
      json['Currency'].forEach((v) {
        currency.add(Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (expense != null) {
      data['Expense'] = expense.toJson();
    }
    if (expenseList != null) {
      data['ExpenseList'] = expenseList.map((v) => v.toJson()).toList();
    }
    if (expenseType != null) {
      data['ExpenseType'] = expenseType.map((v) => v.toJson()).toList();
    }
    if (expenseTypeList != null) {
      data['ExpenseTypeList'] =
          expenseTypeList.map((v) => v.toJson()).toList();
    }
  /*  if (currency != null) {
      data['Currency'] = currency.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Expense {
  int id;
  String name;
  String approver1;
  int approver1Id;
  String approver2;
  int approver2Id;
  String finApprover;
  int finApproverId;
  String description;
  String employee;
  int employeeId;
  String expenseList;
  bool flag;
  Status status;
  int statusId;
  String appliedDate;
  bool billable;
  String comments;
  String approverComments;
  String fINComments;
  bool ticket;
  int advance;
  int travelId;
  int createdBy;
  int modifiedBy;
  String createdDate;
  String modifiedDate;
  bool isRemoved;

  Expense(
      {this.id,
        this.name,
        this.approver1,
        this.approver1Id,
        this.approver2,
        this.approver2Id,
        this.finApprover,
        this.finApproverId,
        this.description,
        this.employee,
        this.employeeId,
        this.expenseList,
        this.flag,
        this.status,
        this.statusId,
        this.appliedDate,
        this.billable,
        this.comments,
        this.approverComments,
        this.fINComments,
        this.ticket,
        this.advance,
        this.travelId,
        this.createdBy,
        this.modifiedBy,
        this.createdDate,
        this.modifiedDate,
        this.isRemoved});

  Expense.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    approver1 = json['Approver1'];
    approver1Id = json['Approver1Id'];
    approver2 = json['Approver2'];
    approver2Id = json['Approver2Id'];
    finApprover = json['FinApprover'];
    finApproverId = json['FinApproverId'];
    description = json['Description'];
    employee = json['Employee'];
    employeeId = json['EmployeeId'];
    expenseList = json['ExpenseList'];
    flag = json['Flag'];
    status =
    json['Status'] != null ? Status.fromJson(json['Status']) : null;
    statusId = json['StatusId'];
    appliedDate = json['AppliedDate'];
    billable = json['Billable'];
    comments = json['Comments'];
    approverComments = json['ApproverComments'];
    fINComments = json['FINComments'];
    ticket = json['Ticket'];
    advance = json['Advance'];
    travelId = json['TravelId'];
    createdBy = json['CreatedBy'];
    modifiedBy = json['ModifiedBy'];
    createdDate = json['CreatedDate'];
    modifiedDate = json['ModifiedDate'];
    isRemoved = json['IsRemoved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Approver1'] = approver1;
    data['Approver1Id'] = approver1Id;
    data['Approver2'] = approver2;
    data['Approver2Id'] = approver2Id;
    data['FinApprover'] = finApprover;
    data['FinApproverId'] = finApproverId;
    data['Description'] = description;
    data['Employee'] = employee;
    data['EmployeeId'] = employeeId;
    data['ExpenseList'] = expenseList;
    data['Flag'] = flag;
    if (status != null) {
      data['Status'] = status.toJson();
    }
    data['StatusId'] = statusId;
    data['AppliedDate'] = appliedDate;
    data['Billable'] = billable;
    data['Comments'] = comments;
    data['ApproverComments'] = approverComments;
    data['FINComments'] = fINComments;
    data['Ticket'] = ticket;
    data['Advance'] = advance;
    data['TravelId'] = travelId;
    data['CreatedBy'] = createdBy;
    data['ModifiedBy'] = modifiedBy;
    data['CreatedDate'] = createdDate;
    data['ModifiedDate'] = modifiedDate;
    data['IsRemoved'] = isRemoved;
    return data;
  }
}

class Status {
  int id;
  String name;
  bool isRemoved;

  Status({this.id, this.name, this.isRemoved});

  Status.fromJson(Map<String, dynamic> json) {
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

class ExpenseList {
  int id;
  double amount;
  String comments;
  int currencyId;
  double exchangeRate;
  String expenseDate;
  String expenseTypeName;
  String expenseName;
  String filePath;
  String fromPlace;
  double mileage;
  String particular;
  double rate;
  bool reimbursable;
  String toPlace;
  int typeId;
  String toDt;
  String fromDt;
  int catId;

  ExpenseList(
      {this.id,
        this.amount,
        this.comments,
        this.currencyId,
        this.exchangeRate,
        this.expenseDate,
        this.expenseTypeName,
        this.expenseName,
        this.filePath,
        this.fromPlace,
        this.mileage,
        this.particular,
        this.rate,
        this.reimbursable,
        this.toPlace,
        this.typeId,
        this.toDt,
        this.fromDt,
        this.catId});

  ExpenseList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    amount = json['Amount'];
    comments = json['Comments'];
    currencyId = json['CurrencyId'];
    exchangeRate = json['ExchangeRate'];
    expenseDate = json['ExpenseDate'];
    expenseTypeName = json['ExpenseTypeName'];
    expenseName = json['ExpenseName'];
    filePath = json['FilePath'];
    fromPlace = json['FromPlace'];
    mileage = json['Mileage'];
    particular = json['Particular'];
    rate = json['Rate'];
    reimbursable = json['Reimbursable'];
    toPlace = json['ToPlace'];
    typeId = json['TypeId'];
    toDt = json['ToDt'];
    fromDt = json['FromDt'];
    catId = json['CatId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Amount'] = amount;
    data['Comments'] = comments;
    data['CurrencyId'] = currencyId;
    data['ExchangeRate'] = exchangeRate;
    data['ExpenseDate'] = expenseDate;
    data['ExpenseTypeName'] = expenseTypeName;
    data['ExpenseName'] = expenseName;
    data['FilePath'] = filePath;
    data['FromPlace'] = fromPlace;
    data['Mileage'] = mileage;
    data['Particular'] = particular;
    data['Rate'] = rate;
    data['Reimbursable'] = reimbursable;
    data['ToPlace'] = toPlace;
    data['TypeId'] = typeId;
    data['ToDt'] = toDt;
    data['FromDt'] = fromDt;
    data['CatId'] = catId;
    return data;
  }
}

class ExpenseType {
  int id;
  String name;
  bool isRemoved;
  int catId;
  String catName;

  ExpenseType({this.id, this.name, this.isRemoved, this.catId, this.catName});

  ExpenseType.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    isRemoved = json['IsRemoved'];
    catId = json['CatId'];
    catName = json['CatName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['IsRemoved'] = isRemoved;
    data['CatId'] = catId;
    data['CatName'] = catName;
    return data;
  }
}

class ExpenseTypeList {
  int catId;
  String catName;

  ExpenseTypeList({this.catId, this.catName});

  ExpenseTypeList.fromJson(Map<String, dynamic> json) {
    catId = json['CatId'];
    catName = json['CatName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CatId'] = catId;
    data['CatName'] = catName;
    return data;
  }
}