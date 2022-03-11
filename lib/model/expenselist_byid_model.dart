class ExpenseListByIdModel {
  ExpenseList expenseList;

  ExpenseListByIdModel({this.expenseList});

  ExpenseListByIdModel.fromJson(Map<String, dynamic> json) {
    expenseList = json['ExpenseList'] != null
        ? ExpenseList.fromJson(json['ExpenseList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (expenseList != null) {
      data['ExpenseList'] = expenseList.toJson();
    }
    return data;
  }
}

class ExpenseList {
  int id;
  String expenseMaster;
  int expenseId;
  String expenseName;
  String expenseDate;
  String fromDate;
  String toDate;
  String fromPlace;
  String toPlace;
  bool reimbursable;
  String expenseType;
  int typeId;
  double mileage;
  double rate;
  int otherCharges;
  int amount;
  int currency;
  int currencyId;
  int exchangeRate;
  String particular;
  String comments;
  String filePath;
  bool isRemoved;

  ExpenseList(
      {this.id,
        this.expenseMaster,
        this.expenseId,
        this.expenseName,
        this.expenseDate,
        this.fromDate,
        this.toDate,
        this.fromPlace,
        this.toPlace,
        this.reimbursable,
        this.expenseType,
        this.typeId,
        this.mileage,
        this.rate,
        this.otherCharges,
        this.amount,
        this.currency,
        this.currencyId,
        this.exchangeRate,
        this.particular,
        this.comments,
        this.filePath,
        this.isRemoved});

  ExpenseList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    expenseMaster = json['ExpenseMaster'];
    expenseId = json['ExpenseId'];
    expenseName = json['ExpenseName'];
    expenseDate = json['ExpenseDate'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    fromPlace = json['FromPlace'];
    toPlace = json['ToPlace'];
    reimbursable = json['Reimbursable'];
    expenseType = json['ExpenseType'];
    typeId = json['TypeId'];
    mileage = json['Mileage'];
    rate = json['Rate'];
    otherCharges = json['OtherCharges'];
    amount = json['Amount'];
    currency = json['Currency'];
    currencyId = json['CurrencyId'];
    exchangeRate = json['ExchangeRate'];
    particular = json['Particular'];
    comments = json['Comments'];
    filePath = json['FilePath'];
    isRemoved = json['IsRemoved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['ExpenseMaster'] = expenseMaster;
    data['ExpenseId'] = expenseId;
    data['ExpenseName'] = expenseName;
    data['ExpenseDate'] = expenseDate;
    data['FromDate'] = fromDate;
    data['ToDate'] = toDate;
    data['FromPlace'] = fromPlace;
    data['ToPlace'] = toPlace;
    data['Reimbursable'] = reimbursable;
    data['ExpenseType'] = expenseType;
    data['TypeId'] = typeId;
    data['Mileage'] = mileage;
    data['Rate'] = rate;
    data['OtherCharges'] = otherCharges;
    data['Amount'] = amount;
    data['Currency'] = currency;
    data['CurrencyId'] = currencyId;
    data['ExchangeRate'] = exchangeRate;
    data['Particular'] = particular;
    data['Comments'] = comments;
    data['FilePath'] = filePath;
    data['IsRemoved'] = isRemoved;
    return data;
  }
}