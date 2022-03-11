class TravelData {
  List<TravelMode> travelMode;
  List<CountryList> countryList;
  List<StateList> stateList;
  List<TravelType> travelType;
  List<Status> status;

  TravelData(
      {this.travelMode,
        this.countryList,
        this.stateList,
        this.travelType,
        this.status});

  TravelData.fromJson(Map<String, dynamic> json) {
    if (json['TravelMode'] != null) {
      travelMode = <TravelMode>[];
      json['TravelMode'].forEach((v) {
        travelMode.add(TravelMode.fromJson(v));
      });
    }
    if (json['CountryList'] != null) {
      countryList = <CountryList>[];
      json['CountryList'].forEach((v) {
        countryList.add(CountryList.fromJson(v));
      });
    }
    if (json['StateList'] != null) {
      stateList = <StateList>[];
      json['StateList'].forEach((v) {
        stateList.add(StateList.fromJson(v));
      });
    }
    if (json['TravelType'] != null) {
      travelType = <TravelType>[];
      json['TravelType'].forEach((v) {
        travelType.add(TravelType.fromJson(v));
      });
    }
    if (json['Status'] != null) {
      status = <Status>[];
      json['Status'].forEach((v) {
        status.add(Status.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (travelMode != null) {
      data['TravelMode'] = travelMode.map((v) => v.toJson()).toList();
    }
    if (countryList != null) {
      data['CountryList'] = countryList.map((v) => v.toJson()).toList();
    }
    if (stateList != null) {
      data['StateList'] = stateList.map((v) => v.toJson()).toList();
    }
    if (travelType != null) {
      data['TravelType'] = travelType.map((v) => v.toJson()).toList();
    }
    if (status != null) {
      data['Status'] = status.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelMode {
  int id;
  String name;

  TravelMode({this.id, this.name});

  TravelMode.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}

class CountryList {
  int id;
  String name;

  CountryList({this.id, this.name});

  CountryList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}

class StateList {
  int id;
  String name;
  int countryId;

  StateList({this.id, this.name, this.countryId});

  StateList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    countryId = json['CountryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['CountryId'] = countryId;
    return data;
  }
}

class TravelType {
  int id;
  String name;

  TravelType({this.id, this.name});

  TravelType.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}

class Status {
  int id;
  String name;
  String statusType;
  String forType;
  bool isRemoved;

  Status({this.id, this.name, this.statusType, this.forType, this.isRemoved});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    statusType = json['StatusType'];
    forType = json['ForType'];
    isRemoved = json['IsRemoved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['StatusType'] = statusType;
    data['ForType'] = forType;
    data['IsRemoved'] = isRemoved;
    return data;
  }
}