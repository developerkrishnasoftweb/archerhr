class ProfileModel {
  EmployeeDet employeeDet;
  EmpStatutory empStatutory;
  List<WorkPermitType> workPermitType;
  List<WorkPermitType> healthCardType;
  List<StatStates> statStates;
  List<EmployeeEduList> employeeEduList;
  List<Edutype> edutype;
  List<EmployeeExpList> employeeExpList;
  List<Edutype> exptype;
  List<EmployeeFamList> employeeFamList;
  List<String> employeeRefList;
  List<FamRelationship> famRelationship;
  List<FamRelationship> refRelationship;
  List<EmployeeSkillList> employeeSkillList;
  List<Edutype> skillslist;
  List<EmployeeBankList> employeeBankList;
  List<ACTypes> aCTypes;
  List<Edutype> oPSTypes;
  List<EmployeeVisaList> employeeVisaList;
  EmployeePassport employeePassport;
  List<EmployeeLangList> employeeLangList;
  List<Langslist> langslist;

  ProfileModel(
      {this.employeeDet,
        this.empStatutory,
        this.workPermitType,
        this.healthCardType,
        this.statStates,
        this.employeeEduList,
        this.edutype,
        this.employeeExpList,
        this.exptype,
        this.employeeFamList,
        this.employeeRefList,
        this.famRelationship,
        this.refRelationship,
        this.employeeSkillList,
        this.skillslist,
        this.employeeBankList,
        this.aCTypes,
        this.oPSTypes,
        this.employeeVisaList,
        this.employeePassport,
        this.employeeLangList,
        this.langslist});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    employeeDet = json['EmployeeDet'] != null ? EmployeeDet.fromJson(json['EmployeeDet']) : null;
    empStatutory = json['EmpStatutory'] != null ? EmpStatutory.fromJson(json['EmpStatutory']) : null;
    if (json['WorkPermitType'] != null) {
      workPermitType = <WorkPermitType>[];
      json['WorkPermitType'].forEach((v) {
        workPermitType.add(WorkPermitType.fromJson(v));
      });
    }
    if (json['HealthCardType'] != null) {
      healthCardType = <WorkPermitType>[];
      json['HealthCardType'].forEach((v) {
        healthCardType.add(WorkPermitType.fromJson(v));
      });
    }
    if (json['StatStates'] != null) {
      statStates = <StatStates>[];
      json['StatStates'].forEach((v) {
        statStates.add(StatStates.fromJson(v));
      });
    }
    if (json['EmployeeEduList'] != null) {
      employeeEduList = <EmployeeEduList>[];
      json['EmployeeEduList'].forEach((v) {
        employeeEduList.add(EmployeeEduList.fromJson(v));
      });
    }
    if (json['Edutype'] != null) {
      edutype = <Edutype>[];
      json['Edutype'].forEach((v) {
        edutype.add(Edutype.fromJson(v));
      });
    }
    if (json['EmployeeExpList'] != null) {
      employeeExpList = <EmployeeExpList>[];
      json['EmployeeExpList'].forEach((v) {
        employeeExpList.add(EmployeeExpList.fromJson(v));
      });
    }
    if (json['Exptype'] != null) {
      exptype = <Edutype>[];
      json['Exptype'].forEach((v) {
        exptype.add(Edutype.fromJson(v));
      });
    }
    if (json['EmployeeFamList'] != null) {
      employeeFamList = <EmployeeFamList>[];
      json['EmployeeFamList'].forEach((v) {
        employeeFamList.add(EmployeeFamList.fromJson(v));
      });
    }
    /*  if (json['EmployeeRefList'] != null) {
      employeeRefList = <Null>[];
      json['EmployeeRefList'].forEach((v) {
        employeeRefList.add(Null.fromJson(v));
      });
    }*/
    if (json['FamRelationship'] != null) {
      famRelationship = <FamRelationship>[];
      json['FamRelationship'].forEach((v) {
        famRelationship.add(FamRelationship.fromJson(v));
      });
    }
    if (json['RefRelationship'] != null) {
      refRelationship = <FamRelationship>[];
      json['RefRelationship'].forEach((v) {
        refRelationship.add(FamRelationship.fromJson(v));
      });
    }
    if (json['EmployeeSkillList'] != null) {
      employeeSkillList = <EmployeeSkillList>[];
      json['EmployeeSkillList'].forEach((v) {
        employeeSkillList.add(EmployeeSkillList.fromJson(v));
      });
    }
    if (json['Skillslist'] != null) {
      skillslist = <Edutype>[];
      json['Skillslist'].forEach((v) {
        skillslist.add(Edutype.fromJson(v));
      });
    }
    if (json['EmployeeBankList'] != null) {
      employeeBankList = <EmployeeBankList>[];
      json['EmployeeBankList'].forEach((v) {
        employeeBankList.add(EmployeeBankList.fromJson(v));
      });
    }
    if (json['ACTypes'] != null) {
      aCTypes = <ACTypes>[];
      json['ACTypes'].forEach((v) {
        aCTypes.add(ACTypes.fromJson(v));
      });
    }
    if (json['OPSTypes'] != null) {
      oPSTypes = <Edutype>[];
      json['OPSTypes'].forEach((v) {
        oPSTypes.add(Edutype.fromJson(v));
      });
    }
    if (json['EmployeeVisaList'] != null) {
      employeeVisaList = <EmployeeVisaList>[];
      json['EmployeeVisaList'].forEach((v) {
        employeeVisaList.add(EmployeeVisaList.fromJson(v));
      });
    }
    employeePassport = json['EmployeePassport'] != null ? EmployeePassport.fromJson(json['EmployeePassport']) : null;
    if (json['EmployeeLangList'] != null) {
      employeeLangList = <EmployeeLangList>[];
      json['EmployeeLangList'].forEach((v) {
        employeeLangList.add(EmployeeLangList.fromJson(v));
      });
    }
    if (json['Langslist'] != null) {
      langslist = <Langslist>[];
      json['Langslist'].forEach((v) {
        langslist.add(Langslist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employeeDet != null) {
      data['EmployeeDet'] = employeeDet.toJson();
    }
    if (empStatutory != null) {
      data['EmpStatutory'] = empStatutory.toJson();
    }
    if (workPermitType != null) {
      data['WorkPermitType'] = workPermitType.map((v) => v.toJson()).toList();
    }
    if (healthCardType != null) {
      data['HealthCardType'] = healthCardType.map((v) => v.toJson()).toList();
    }
    if (statStates != null) {
      data['StatStates'] = statStates.map((v) => v.toJson()).toList();
    }
    if (employeeEduList != null) {
      data['EmployeeEduList'] = employeeEduList.map((v) => v.toJson()).toList();
    }
    if (edutype != null) {
      data['Edutype'] = edutype.map((v) => v.toJson()).toList();
    }
    if (employeeExpList != null) {
      data['EmployeeExpList'] = employeeExpList.map((v) => v.toJson()).toList();
    }
    if (exptype != null) {
      data['Exptype'] = exptype.map((v) => v.toJson()).toList();
    }
    if (employeeFamList != null) {
      data['EmployeeFamList'] = employeeFamList.map((v) => v.toJson()).toList();
    }
    /*if (employeeRefList != null) {
      data['EmployeeRefList'] =
          employeeRefList.map((v) => v.toJson()).toList();
    }*/
    if (famRelationship != null) {
      data['FamRelationship'] = famRelationship.map((v) => v.toJson()).toList();
    }
    if (refRelationship != null) {
      data['RefRelationship'] = refRelationship.map((v) => v.toJson()).toList();
    }
    if (employeeSkillList != null) {
      data['EmployeeSkillList'] = employeeSkillList.map((v) => v.toJson()).toList();
    }
    if (skillslist != null) {
      data['Skillslist'] = skillslist.map((v) => v.toJson()).toList();
    }
    if (employeeBankList != null) {
      data['EmployeeBankList'] = employeeBankList.map((v) => v.toJson()).toList();
    }
    if (aCTypes != null) {
      data['ACTypes'] = aCTypes.map((v) => v.toJson()).toList();
    }
    if (oPSTypes != null) {
      data['OPSTypes'] = oPSTypes.map((v) => v.toJson()).toList();
    }
    if (employeeVisaList != null) {
      data['EmployeeVisaList'] = employeeVisaList.map((v) => v.toJson()).toList();
    }
    if (employeePassport != null) {
      data['EmployeePassport'] = employeePassport.toJson();
    }
    if (employeeLangList != null) {
      data['EmployeeLangList'] = employeeLangList.map((v) => v.toJson()).toList();
    }
    if (langslist != null) {
      data['Langslist'] = langslist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Manger {
  String firstName;
  String lastName;

  Manger({this.firstName, this.lastName});

  Manger.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    lastName = json['LastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    return data;
  }
}

class EmployeeDet {
  String aboutMe;
  int bandId;
  String bandName;
  String bloodgroup;
  int branchId;
  String branchName;
  String buName;
  int buId;
  String comCity;
  String comCountryName;
  int comCountryId;
  String comPostcode;
  String comLine1;
  String comLine2;
  String comLine3;
  String comStateName;
  int comStateId;
  String contactno1;
  String contactno2;
  String dept;
  int departmentId;
  String desg;
  int designationId;
  String dOB;
  String dOJ;
  String empId;
  String empType;
  int employeeTypeId;
  String emrContact;
  String emrNo;
  String fatherName;
  String firstName;
  String genderName;
  int genderId;
  int id;
  String landline;
  String lastName;
  String maidenName;
  String marital;
  int maritalStatusId;
  String marriageDate;
  String middleName;
  String mobileno;
  String mobileno1;
  String motherName;
  String nationalityName;
  int nationalityId;
  String oldpassportNo;
  String passportIssueDate;
  String passportIssuePlace;
  String passportNo;
  String passportValidity;
  String permCity;
  String permCountryName;
  int permCountryId;
  String permFrom;
  String permLine1;
  String permLine2;
  String permLine3;
  String permPostcode;
  String permStateName;
  int permStateId;
  String photoName;
  String placeofBirth;
  bool pPStatusId;
  String priEmail;
  int reportingMgr;
  String secEmail;
  String spouseName;
  String stayFrom;
  String title;
  Manger manger;

  EmployeeDet(
      {this.aboutMe,
        this.bandId,
        this.bandName,
        this.bloodgroup,
        this.branchId,
        this.branchName,
        this.buName,
        this.comPostcode,
        this.buId,
        this.comCity,
        this.comCountryName,
        this.comCountryId,
        this.comLine1,
        this.comLine2,
        this.comLine3,
        this.comStateName,
        this.comStateId,
        this.contactno1,
        this.contactno2,
        this.dept,
        this.departmentId,
        this.desg,
        this.designationId,
        this.dOB,
        this.dOJ,
        this.empId,
        this.empType,
        this.employeeTypeId,
        this.emrContact,
        this.emrNo,
        this.fatherName,
        this.firstName,
        this.genderName,
        this.genderId,
        this.id,
        this.landline,
        this.lastName,
        this.maidenName,
        this.marital,
        this.maritalStatusId,
        this.marriageDate,
        this.middleName,
        this.mobileno,
        this.mobileno1,
        this.motherName,
        this.nationalityName,
        this.nationalityId,
        this.oldpassportNo,
        this.passportIssueDate,
        this.passportIssuePlace,
        this.passportNo,
        this.passportValidity,
        this.permCity,
        this.permCountryName,
        this.permCountryId,
        this.permFrom,
        this.permLine1,
        this.permLine2,
        this.permLine3,
        this.permPostcode,
        this.permStateName,
        this.permStateId,
        this.photoName,
        this.placeofBirth,
        this.pPStatusId,
        this.priEmail,
        this.reportingMgr,
        this.secEmail,
        this.spouseName,
        this.stayFrom,
        this.title,
        this.manger
      });

  EmployeeDet.fromJson(Map<String, dynamic> json) {
    aboutMe = json['AboutMe'];
    bandId = json['BandId'];
    bandName = json['BandName'];
    bloodgroup = json['Bloodgroup'];
    branchId = json['BranchId'];
    branchName = json['BranchName'];
    buName = json['BuName'];
    buId = json['BuId'];
    comCity = json['ComCity'];
    comCountryName = json['ComCountryName'];
    comCountryId = json['ComCountryId'];
    comPostcode = json['ComPostcode'];
    comLine1 = json['ComLine1'];
    comLine2 = json['ComLine2'];
    comLine3 = json['ComLine3'];
    comStateName = json['ComStateName'];
    comStateId = json['ComStateId'];
    contactno1 = json['Contactno1'];
    contactno2 = json['Contactno2'];
    dept = json['Dept'];
    departmentId = json['DepartmentId'];
    desg = json['Desg'];
    designationId = json['DesignationId'];
    dOB = json['DOB'];
    dOJ = json['DOJ'];
    empId = json['EmpId'];
    empType = json['EmpType'];
    employeeTypeId = json['EmployeeTypeId'];
    emrContact = json['Emr_contact'];
    emrNo = json['Emr_no'];
    fatherName = json['FatherName'];
    firstName = json['FirstName'];
    genderName = json['GenderName'];
    genderId = json['GenderId'];
    id = json['Id'];
    landline = json['Landline'];
    lastName = json['LastName'];
    maidenName = json['MaidenName'];
    marital = json['Marital'];
    maritalStatusId = json['MaritalStatusId'];
    marriageDate = json['MarriageDate'];
    middleName = json['MiddleName'];
    mobileno = json['Mobileno'];
    mobileno1 = json['Mobileno1'];
    motherName = json['MotherName'];
    nationalityName = json['NationalityName'];
    nationalityId = json['NationalityId'];
    oldpassportNo = json['OldpassportNo'];
    passportIssueDate = json['PassportIssueDate'];
    passportIssuePlace = json['PassportIssuePlace'];
    passportNo = json['PassportNo'];
    passportValidity = json['PassportValidity'];
    permCity = json['PermCity'];
    permCountryName = json['PermCountryName'];
    permCountryId = json['PermCountryId'];
    permFrom = json['PermFrom'];
    permLine1 = json['PermLine1'];
    permLine2 = json['PermLine2'];
    permLine3 = json['PermLine3'];
    permPostcode = json['PermPostcode'];
    permStateName = json['PermStateName'];
    permStateId = json['PermStateId'];
    photoName = json['PhotoName'];
    placeofBirth = json['PlaceofBirth'];
    pPStatusId = json['PPStatusId'];
    priEmail = json['Pri_email'];
    reportingMgr = json['ReportingMgr'];
    secEmail = json['Sec_email'];
    spouseName = json['SpouseName'];
    stayFrom = json['StayFrom'];
    title = json['Title'];
    manger =
    json['Manger'] != null ? Manger.fromJson(json['Manger']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AboutMe'] = aboutMe;
    data['BandId'] = bandId;
    data['BandName'] = bandName;
    data['Bloodgroup'] = bloodgroup;
    data['BranchId'] = branchId;
    data['BranchName'] = branchName;
    data['BuName'] = buName;
    data['BuId'] = buId;
    data['ComCity'] = comCity;
    data['ComCountryName'] = comCountryName;
    data['ComCountryId'] = comCountryId;
    data['ComPostcode'] = comPostcode;
    data['ComLine1'] = comLine1;
    data['ComLine2'] = comLine2;
    data['ComLine3'] = comLine3;
    data['ComStateName'] = comStateName;
    data['ComStateId'] = comStateId;
    data['Contactno1'] = contactno1;
    data['Contactno2'] = contactno2;
    data['Dept'] = dept;
    data['DepartmentId'] = departmentId;
    data['Desg'] = desg;
    data['DesignationId'] = designationId;
    data['DOB'] = dOB;
    data['DOJ'] = dOJ;
    data['EmpId'] = empId;
    data['EmpType'] = empType;
    data['EmployeeTypeId'] = employeeTypeId;
    data['Emr_contact'] = emrContact;
    data['Emr_no'] = emrNo;
    data['FatherName'] = fatherName;
    data['FirstName'] = firstName;
    data['GenderName'] = genderName;
    data['GenderId'] = genderId;
    data['Id'] = id;
    data['Landline'] = landline;
    data['LastName'] = lastName;
    data['MaidenName'] = maidenName;
    data['Marital'] = marital;
    data['MaritalStatusId'] = maritalStatusId;
    data['MarriageDate'] = marriageDate;
    data['MiddleName'] = middleName;
    data['Mobileno'] = mobileno;
    data['Mobileno1'] = mobileno1;
    data['MotherName'] = motherName;
    data['NationalityName'] = nationalityName;
    data['NationalityId'] = nationalityId;
    data['OldpassportNo'] = oldpassportNo;
    data['PassportIssueDate'] = passportIssueDate;
    data['PassportIssuePlace'] = passportIssuePlace;
    data['PassportNo'] = passportNo;
    data['PassportValidity'] = passportValidity;
    data['PermCity'] = permCity;
    data['PermCountryName'] = permCountryName;
    data['PermCountryId'] = permCountryId;
    data['PermFrom'] = permFrom;
    data['PermLine1'] = permLine1;
    data['PermLine2'] = permLine2;
    data['PermLine3'] = permLine3;
    data['PermPostcode'] = permPostcode;
    data['PermStateName'] = permStateName;
    data['PermStateId'] = permStateId;
    data['PhotoName'] = photoName;
    data['PlaceofBirth'] = placeofBirth;
    data['PPStatusId'] = pPStatusId;
    data['Pri_email'] = priEmail;
    data['ReportingMgr'] = reportingMgr;
    data['Sec_email'] = secEmail;
    data['SpouseName'] = spouseName;
    data['StayFrom'] = stayFrom;
    data['Title'] = title;
    if (manger != null) {
      data['Manger'] = manger.toJson();
    }
    return data;
  }
}

class EmpStatutory {
  String countryBaseName;
  int countryBaseId;
  String drivingLicense;
  bool gratuity;
  String healthCardNo1;
  String healthCardNo2;
  String hCType1;
  String hCType2;
  int healthCardTypeId1;
  int healthCardTypeId2;
  bool insuranceCovered;
  String lWFLocation;
  String nationalIdNo;
  String pANCardNo;
  bool pFApplicable;
  String pFLocation;
  String pFNo;
  String pFNominee1;
  String pFNominee2;
  String pFStartDate;
  bool pFTransfered;
  String stateName;
  bool taxApplicable;
  int taxStateId;
  String uANNo;
  int voterId;
  int workPermit;
  String workPermitNo;
  String workPermitName;

  EmpStatutory(
      {this.countryBaseName,
        this.countryBaseId,
        this.drivingLicense,
        this.gratuity,
        this.healthCardNo1,
        this.healthCardNo2,
        this.hCType1,
        this.hCType2,
        this.healthCardTypeId1,
        this.healthCardTypeId2,
        this.insuranceCovered,
        this.lWFLocation,
        this.nationalIdNo,
        this.pANCardNo,
        this.pFApplicable,
        this.pFLocation,
        this.pFNo,
        this.pFNominee1,
        this.pFNominee2,
        this.pFStartDate,
        this.pFTransfered,
        this.stateName,
        this.taxApplicable,
        this.taxStateId,
        this.uANNo,
        this.voterId,
        this.workPermit,
        this.workPermitNo,
        this.workPermitName});

  EmpStatutory.fromJson(Map<String, dynamic> json) {
    countryBaseName = json['CountryBaseName'];
    countryBaseId = json['CountryBaseId'];
    drivingLicense = json['DrivingLicense'];
    gratuity = json['Gratuity'];
    healthCardNo1 = json['HealthCardNo1'];
    healthCardNo2 = json['HealthCardNo2'];
    hCType1 = json['HCType1'];
    hCType2 = json['HCType2'];
    healthCardTypeId1 = json['HealthCardTypeId1'];
    healthCardTypeId2 = json['HealthCardTypeId2'];
    insuranceCovered = json['InsuranceCovered'];
    lWFLocation = json['LWFLocation'];
    nationalIdNo = json['NationalIdNo'];
    pANCardNo = json['PANCardNo'];
    pFApplicable = json['PFApplicable'];
    pFLocation = json['PFLocation'];
    pFNo = json['PFNo'];
    pFNominee1 = json['PFNominee1'];
    pFNominee2 = json['PFNominee2'];
    pFStartDate = json['PFStartDate'];
    pFTransfered = json['PFTransfered'];
    stateName = json['StateName'];
    taxApplicable = json['TaxApplicable'];
    taxStateId = json['TaxStateId'];
    uANNo = json['UANNo'];
    voterId = json['VoterId'];
    workPermit = json['WorkPermit'];
    workPermitNo = json['WorkPermitNo'];
    workPermitName = json['WorkPermitName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CountryBaseName'] = countryBaseName;
    data['CountryBaseId'] = countryBaseId;
    data['DrivingLicense'] = drivingLicense;
    data['Gratuity'] = gratuity;
    data['HealthCardNo1'] = healthCardNo1;
    data['HealthCardNo2'] = healthCardNo2;
    data['HCType1'] = hCType1;
    data['HCType2'] = hCType2;
    data['HealthCardTypeId1'] = healthCardTypeId1;
    data['HealthCardTypeId2'] = healthCardTypeId2;
    data['InsuranceCovered'] = insuranceCovered;
    data['LWFLocation'] = lWFLocation;
    data['NationalIdNo'] = nationalIdNo;
    data['PANCardNo'] = pANCardNo;
    data['PFApplicable'] = pFApplicable;
    data['PFLocation'] = pFLocation;
    data['PFNo'] = pFNo;
    data['PFNominee1'] = pFNominee1;
    data['PFNominee2'] = pFNominee2;
    data['PFStartDate'] = pFStartDate;
    data['PFTransfered'] = pFTransfered;
    data['StateName'] = stateName;
    data['TaxApplicable'] = taxApplicable;
    data['TaxStateId'] = taxStateId;
    data['UANNo'] = uANNo;
    data['VoterId'] = voterId;
    data['WorkPermit'] = workPermit;
    data['WorkPermitNo'] = workPermitNo;
    data['WorkPermitName'] = workPermitName;
    return data;
  }
}

class WorkPermitType {
  int id;
  String name;
  bool isRemoved;

  WorkPermitType({this.id, this.name, this.isRemoved});

  WorkPermitType.fromJson(Map<String, dynamic> json) {
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

class StatStates {
  String country;
  int countryId;
  int id;
  String name;
  bool isRemoved;

  StatStates({this.country, this.countryId, this.id, this.name, this.isRemoved});

  StatStates.fromJson(Map<String, dynamic> json) {
    country = json['Country'];
    countryId = json['CountryId'];
    id = json['Id'];
    name = json['Name'];
    isRemoved = json['IsRemoved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Country'] = country;
    data['CountryId'] = countryId;
    data['Id'] = id;
    data['Name'] = name;
    data['IsRemoved'] = isRemoved;
    return data;
  }
}

class EmployeeEduList {
  int id;
  String country;
  int countryId;
  int stateId;
  String state;
  String yos;
  String yoc;
  double percentage;
  String graduation;
  int educationTypeId;
  String elective;
  int employeeId;
  String city;
  String courses;
  String degree;
  String university;

  EmployeeEduList(
      {this.id,
        this.country,
        this.countryId,
        this.stateId,
        this.state,
        this.yos,
        this.yoc,
        this.percentage,
        this.graduation,
        this.educationTypeId,
        this.elective,
        this.employeeId,
        this.city,
        this.courses,
        this.degree,
        this.university});

  EmployeeEduList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    country = json['Country'];
    countryId = json['CountryId'];
    stateId = json['StateId'];
    state = json['State'];
    yos = json['Yos'];
    yoc = json['Yoc'];
    percentage = json['Percentage'];
    graduation = json['Graduation'];
    educationTypeId = json['EducationTypeId'];
    elective = json['Elective'];
    employeeId = json['EmployeeId'];
    city = json['City'];
    courses = json['Courses'];
    degree = json['Degree'];
    university = json['University'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Country'] = country;
    data['CountryId'] = countryId;
    data['StateId'] = stateId;
    data['State'] = state;
    data['Yos'] = yos;
    data['Yoc'] = yoc;
    data['Percentage'] = percentage;
    data['Graduation'] = graduation;
    data['EducationTypeId'] = educationTypeId;
    data['Elective'] = elective;
    data['EmployeeId'] = employeeId;
    data['City'] = city;
    data['Courses'] = courses;
    data['Degree'] = degree;
    data['University'] = university;
    return data;
  }
}

class Edutype {
  int id;
  String type;
  bool isRemoved;

  Edutype({this.id, this.type, this.isRemoved});

  Edutype.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    type = json['Type'];
    isRemoved = json['IsRemoved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Type'] = type;
    data['IsRemoved'] = isRemoved;
    return data;
  }
}

class EmployeeExpList {
  int id;
  String country;
  int countryId;
  int stateId;
  String state;
  String doj;
  String dor;
  String companyName;
  String position;
  int employeeId;
  String city;
  String type;

  EmployeeExpList(
      {this.id,
        this.country,
        this.countryId,
        this.stateId,
        this.state,
        this.doj,
        this.dor,
        this.companyName,
        this.position,
        this.employeeId,
        this.city,
        this.type});

  EmployeeExpList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    country = json['Country'];
    countryId = json['CountryId'];
    stateId = json['StateId'];
    state = json['State'];
    doj = json['Doj'];
    dor = json['Dor'];
    companyName = json['CompanyName'];
    position = json['Position'];
    employeeId = json['EmployeeId'];
    city = json['City'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Country'] = country;
    data['CountryId'] = countryId;
    data['StateId'] = stateId;
    data['State'] = state;
    data['Doj'] = doj;
    data['Dor'] = dor;
    data['CompanyName'] = companyName;
    data['Position'] = position;
    data['EmployeeId'] = employeeId;
    data['City'] = city;
    data['Type'] = type;
    return data;
  }
}

class EmployeeFamList {
  int id;
  String name;
  String relationship;
  String dob;
  int age;
  int employeeId;
  String marital;
  String nationality;
  int nationalityId;
  String occupation;
  String govtId;
  int maritalStatusId;
  String gender;
  bool dependent;

  EmployeeFamList(
      {this.id,
        this.name,
        this.relationship,
        this.dob,
        this.age,
        this.employeeId,
        this.marital,
        this.nationality,
        this.nationalityId,
        this.occupation,
        this.govtId,
        this.maritalStatusId,
        this.gender,
        this.dependent});

  EmployeeFamList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    relationship = json['Relationship'];
    dob = json['Dob'];
    age = json['Age'];
    employeeId = json['EmployeeId'];
    marital = json['Marital'];
    nationality = json['Nationality'];
    nationalityId = json['NationalityId'];
    occupation = json['Occupation'];
    govtId = json['GovtId'];
    maritalStatusId = json['MaritalStatusId'];
    gender = json['Gender'];
    dependent = json['Dependent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Relationship'] = relationship;
    data['Dob'] = dob;
    data['Age'] = age;
    data['EmployeeId'] = employeeId;
    data['Marital'] = marital;
    data['Nationality'] = nationality;
    data['NationalityId'] = nationalityId;
    data['Occupation'] = occupation;
    data['GovtId'] = govtId;
    data['MaritalStatusId'] = maritalStatusId;
    data['Gender'] = gender;
    data['Dependent'] = dependent;
    return data;
  }
}

class FamRelationship {
  int id;
  String name;
  bool isRemoved;
  bool family;

  FamRelationship({this.id, this.name, this.isRemoved, this.family});

  FamRelationship.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    isRemoved = json['IsRemoved'];
    family = json['Family'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['IsRemoved'] = isRemoved;
    data['Family'] = family;
    return data;
  }
}

class EmployeeSkillList {
  int id;
  int employeeId;
  int exp;
  String name;
  int scale;
  String skill;

  EmployeeSkillList({this.id, this.employeeId, this.exp, this.name, this.scale, this.skill});

  EmployeeSkillList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    employeeId = json['EmployeeId'];
    exp = json['Exp'];
    name = json['Name'];
    scale = json['Scale'];
    skill = json['Skill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['EmployeeId'] = employeeId;
    data['Exp'] = exp;
    data['Name'] = name;
    data['Scale'] = scale;
    data['Skill'] = skill;
    return data;
  }
}

class EmployeeBankList {
  int id;
  int employeeId;
  String accountname;
  String aCType;
  String aCNo1;
  String oPType;
  String iFSC;
  String branch;
  String bankName;

  EmployeeBankList(
      {this.id, this.employeeId, this.accountname, this.aCType, this.aCNo1, this.oPType, this.iFSC, this.branch, this.bankName});

  EmployeeBankList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    employeeId = json['EmployeeId'];
    accountname = json['Accountname'];
    aCType = json['ACType'];
    aCNo1 = json['ACNo1'];
    oPType = json['OPType'];
    iFSC = json['IFSC'];
    branch = json['Branch'];
    bankName = json['BankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['EmployeeId'] = employeeId;
    data['Accountname'] = accountname;
    data['ACType'] = aCType;
    data['ACNo1'] = aCNo1;
    data['OPType'] = oPType;
    data['IFSC'] = iFSC;
    data['Branch'] = branch;
    data['BankName'] = bankName;
    return data;
  }
}

class ACTypes {
  int id;
  String name;

  ACTypes({this.id, this.name});

  ACTypes.fromJson(Map<String, dynamic> json) {
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

class EmployeeVisaList {
  int id;
  String visaNo;
  String visaValidity;
  String country;
  String visaType;
  String visaImg;

  EmployeeVisaList({this.id, this.visaNo, this.visaValidity, this.country, this.visaType, this.visaImg});

  EmployeeVisaList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    visaNo = json['VisaNo'];
    visaValidity = json['VisaValidity'];
    country = json['Country'];
    visaType = json['VisaType'];
    visaImg = json['VisaImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['VisaNo'] = visaNo;
    data['VisaValidity'] = visaValidity;
    data['Country'] = country;
    data['VisaType'] = visaType;
    data['VisaImg'] = visaImg;
    return data;
  }
}

class EmployeePassport {
  int id;
  String employee;
  int employeeId;
  String passportStatus;
  int statusId;
  String nameinPassport;
  String passportNo;
  String oldpassportNo;
  String issueDate;
  String validity;
  String createdDate;
  String modifiedDate;
  String country;
  int countryId;
  String issuePlace;
  bool isRemoved;

  EmployeePassport(
      {this.id,
        this.employee,
        this.employeeId,
        this.passportStatus,
        this.statusId,
        this.nameinPassport,
        this.passportNo,
        this.oldpassportNo,
        this.issueDate,
        this.validity,
        this.createdDate,
        this.modifiedDate,
        this.country,
        this.countryId,
        this.issuePlace,
        this.isRemoved});

  EmployeePassport.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    employee = json['Employee'];
    employeeId = json['EmployeeId'];
    passportStatus = json['PassportStatus'];
    statusId = json['StatusId'];
    nameinPassport = json['NameinPassport'];
    passportNo = json['PassportNo'];
    oldpassportNo = json['OldpassportNo'];
    issueDate = json['IssueDate'];
    validity = json['Validity'];
    createdDate = json['CreatedDate'];
    modifiedDate = json['ModifiedDate'];
    country = json['Country'];
    countryId = json['CountryId'];
    issuePlace = json['IssuePlace'];
    isRemoved = json['IsRemoved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Employee'] = employee;
    data['EmployeeId'] = employeeId;
    data['PassportStatus'] = passportStatus;
    data['StatusId'] = statusId;
    data['NameinPassport'] = nameinPassport;
    data['PassportNo'] = passportNo;
    data['OldpassportNo'] = oldpassportNo;
    data['IssueDate'] = issueDate;
    data['Validity'] = validity;
    data['CreatedDate'] = createdDate;
    data['ModifiedDate'] = modifiedDate;
    data['Country'] = country;
    data['CountryId'] = countryId;
    data['IssuePlace'] = issuePlace;
    data['IsRemoved'] = isRemoved;
    return data;
  }
}

class EmployeeLangList {
  int id;
  String lang;
  bool write;
  bool speak;
  bool isMotherTongue;
  bool read;

  EmployeeLangList({this.id, this.lang, this.write, this.speak, this.isMotherTongue, this.read});

  EmployeeLangList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    lang = json['Lang'];
    write = json['Write'];
    speak = json['Speak'];
    isMotherTongue = json['IsMotherTongue'];
    read = json['Read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Lang'] = lang;
    data['Write'] = write;
    data['Speak'] = speak;
    data['IsMotherTongue'] = isMotherTongue;
    data['Read'] = read;
    return data;
  }
}

class Langslist {
  int id;
  String name;
  String countryBase;
  int countryBaseId;
  bool isRemoved;

  Langslist({this.id, this.name, this.countryBase, this.countryBaseId, this.isRemoved});

  Langslist.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    countryBase = json['CountryBase'];
    countryBaseId = json['CountryBaseId'];
    isRemoved = json['IsRemoved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['CountryBase'] = countryBase;
    data['CountryBaseId'] = countryBaseId;
    data['IsRemoved'] = isRemoved;
    return data;
  }
}
