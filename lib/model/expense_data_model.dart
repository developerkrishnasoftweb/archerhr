class ExpenseFieldModel {
  List<Null> allowanceType;
  List<ExpenseType> expenseType;
  List<Null> currency;

  ExpenseFieldModel({this.allowanceType, this.expenseType, this.currency});

  ExpenseFieldModel.fromJson(Map<String, dynamic> json) {
    /*if (json['AllowanceType'] != null) {
      allowanceType = <Null>[];
      json['AllowanceType'].forEach((v) {
        allowanceType.add(Null.fromJson(v));
      });
    }*/
    if (json['ExpenseType'] != null) {
      expenseType = <ExpenseType>[];
      json['ExpenseType'].forEach((v) {
        expenseType.add(ExpenseType.fromJson(v));
      });
    }
/*    if (json['Currency'] != null) {
      currency = <Null>[];
      json['Currency'].forEach((v) {
        currency.add(Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
  /*  if (this.allowanceType != null) {
      data['AllowanceType'] =
          this.allowanceType!.map((v) => v.toJson()).toList();
    }*/
    if (expenseType != null) {
      data['ExpenseType'] = expenseType.map((v) => v.toJson()).toList();
    }
/*    if (this.currency != null) {
      data['Currency'] = this.currency!.map((v) => v.toJson()).toList();
    }*/
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