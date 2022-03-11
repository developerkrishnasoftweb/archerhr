import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/model/profile_model.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel profileModel = ProfileModel();
  bool loading = false;
  EmployeeDet _employeeDetail;
  List<EmployeeEduList> _employeeEducationList = [];
  List<EmployeeExpList> _employeeExperienceList = [];
  List<EmployeeSkillList> _employeeSkillList = [];
  List<EmployeeLangList> _employeeLanguageList = [];
  List<EmployeeFamList> _employeeFamilyList = [];
  List<EmployeeBankList> _employeeBankList = [];
  List<EmployeeVisaList> _employeeVisaList = [];
  List<WorkPermitType> _workPermitType = [];
  List<WorkPermitType> _healthCardType1Type = [];
  List<StatStates> _statStates = [];
  EmpStatutory _employeeStatutory;
  EmployeePassport _employeePassport;
  //List<String> _employeeReferencesList = [];

  EmployeeDet get employeeDetail => _employeeDetail;
  EmployeePassport get employeePassport => _employeePassport;

  List<EmployeeEduList> get employeeEducationList => _employeeEducationList;
  List<EmployeeExpList> get employeeExperienceList => _employeeExperienceList;
  List<EmployeeSkillList> get employeeSkillList => _employeeSkillList;
  List<EmployeeLangList> get employeeLanguageList => _employeeLanguageList;
  List<EmployeeFamList> get employeeFamilyList => _employeeFamilyList;
  List<EmployeeBankList> get employeeBankList => _employeeBankList;
  List<EmployeeVisaList> get employeeVisaList => _employeeVisaList;
  List<WorkPermitType> get workPermitType => _workPermitType;
  List<WorkPermitType> get healthCardType1Type => _healthCardType1Type;
  List<StatStates> get statStates => _statStates;
  EmpStatutory get employeeStatutory => _employeeStatutory;
  //List<String> get employeeReferencesList => _employeeReferencesList;

  void getProfile(context) async {
    loading = true;

    final response = await getProfileData();
    if (response.statusCode == 200) {
      profileModel = response.data;
      _employeeDetail = response.data.employeeDet;
      _employeeEducationList = response.data.employeeEduList;
      _employeeExperienceList = response.data.employeeExpList;
      _employeeSkillList = response.data.employeeSkillList;
      _employeeLanguageList = response.data.employeeLangList;
      _employeeFamilyList = response.data.employeeFamList;
      _employeeBankList = response.data.employeeBankList;
      _employeePassport = response.data.employeePassport;
      _employeeVisaList = response.data.employeeVisaList;
      _employeeStatutory = response.data.empStatutory;
      _workPermitType = response.data.workPermitType;
      _healthCardType1Type = response.data.healthCardType;
      _statStates = response.data.statStates;
      //_employeeReferencesList = response.data.;
    } else {
      unAuthenticationDialog(context);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> clear() async {
    loading = true;
    _employeeEducationList = [];
    _employeeExperienceList = [];
    _employeeSkillList = [];
    _employeeLanguageList = [];
    _employeeFamilyList = [];
    _employeeBankList = [];
    _employeeVisaList = [];
    _workPermitType = [];
    _healthCardType1Type = [];
    _statStates = [];
    //_employeeReferencesList = [];
  }
}