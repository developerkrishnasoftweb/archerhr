import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:archerhr_mobile/const/const_api.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/model/dashboard_data_model.dart';
import 'package:archerhr_mobile/model/data_model.dart';
import 'package:archerhr_mobile/model/directory_data_byid_model.dart';
import 'package:archerhr_mobile/model/directory_list_data_model.dart';
import 'package:archerhr_mobile/model/expense_approval_model.dart';
import 'package:archerhr_mobile/model/expense_data_model.dart';
import 'package:archerhr_mobile/model/expense_list_data_model.dart';
import 'package:archerhr_mobile/model/getexpense_byid_model.dart';
import 'package:archerhr_mobile/model/getleave_byid_model.dart';
import 'package:archerhr_mobile/model/gettravel_byid_model.dart';
import 'package:archerhr_mobile/model/home_details_model.dart';
import 'package:archerhr_mobile/model/leave_approval_model.dart';
import 'package:archerhr_mobile/model/leave_data_model.dart';
import 'package:archerhr_mobile/model/profile_model.dart';
import 'package:archerhr_mobile/model/punch_model.dart';
import 'package:archerhr_mobile/model/travel_approval_model.dart';
import 'package:archerhr_mobile/model/travel_data_model.dart';
import 'package:archerhr_mobile/model/travel_list_data_model.dart';
import 'package:http/http.dart' as http;

/// error message if there is any unhandled or unexpected
/// error while requesting for any of api
const String _errorMessage = 'Something went wrong, please try later';
const String _noInternetConnection = 'No internet connection';

///HEADERS
var headers = {
  'Content-Type': 'application/json',
  'Cookie': kSharedPreferences.getString("Cookie"),
};

///LOGIN
Future<http.Response> login(String userName, String password) {
  return http.post(
    Uri.parse(Urls.baseUrl + Urls.login),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': userName,
      'password': password,
    }),
  );
}

///GET LEAVE DATA
Future<Data<LeaveData>> getLeaveData() async {
  try {
    final response = await http.get(Uri.parse(Urls.baseUrl + Urls.getLeave), headers: headers);
    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonResponse["value"] != "unauthorized") {
      LeaveData leaveData = LeaveData.fromJson(jsonResponse);
      return Data(data: leaveData, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    return const Data(message: _errorMessage);
  }
}

///SAVE FULL LEAVE
Future<http.StreamedResponse> saveFullLeave(Map<String, Object> body) async {
  try {
    var request = http.Request('POST', Uri.parse(Urls.baseUrl + Urls.saveLeave));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    return await request.send();
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///UPDATE LEAVE
Future<http.StreamedResponse> updateLeave(Map<String, Object> body) async {
  try {
    var request = http.Request('POST', Uri.parse(Urls.baseUrl + Urls.updateLeave));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    return await request.send();
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///GET LEAVE BY ID
Future<Data<GetLeave>> getLeaveInfoById(queryParameter) async {
  try {
    final response =
        await http.get(Uri.parse(Urls.baseUrl + Urls.getLeaveById).replace(queryParameters: queryParameter), headers: headers);
    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      GetLeave getLeave = GetLeave.fromJson(jsonResponse);
      return Data(data: getLeave, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    return const Data(message: _errorMessage);
  }
}

///DELETE LEAVE ID
Future<http.Response> deleteLeaveId(queryParameter) async {
  try {
    return await http.get(
      Uri.parse(Urls.baseUrl + Urls.deleteLeave).replace(queryParameters: queryParameter),
      headers: headers,
    );
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///GET TRAVEL DATA
Future<Data<TravelData>> getTravelData() async {
  try {
    final response = await http.get(Uri.parse(Urls.baseUrl + Urls.getFieldTravel), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      TravelData travelData = TravelData.fromJson(jsonResponse);
      return Data(data: travelData, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    return const Data(message: _errorMessage);
  }
}

///GET TRAVEL LIST
Future<Data<TravelListModel>> getTravelListData() async {
  try {
    final response = await http.get(Uri.parse(Urls.baseUrl + Urls.travelList), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      TravelListModel travelListModel = TravelListModel.fromJson(jsonResponse);
      return Data(data: travelListModel, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    return const Data(message: _errorMessage);
  }
}

///SAVE & UPDATE DOMESTIC TRAVEL
Future<http.StreamedResponse> saveDomesticTravel(Map<String, Object> body) async {
  try {
    var request = http.Request('POST', Uri.parse(Urls.baseUrl + Urls.addUpdateDomesticTravel));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    return await request.send();
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///SAVE & UPDATE INTERNATIONAL TRAVEL
Future<http.StreamedResponse> saveInternationalTravel(Map<String, Object> body) async {
  try {
    var request = http.Request('POST', Uri.parse(Urls.baseUrl + Urls.addUpdateInternationalTravel));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    return await request.send();
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///GET TRAVEL BY ID
Future<Data<GetTravel>> getTravelInfoById(queryParameter) async {
  try {
    final response =
        await http.get(Uri.parse(Urls.baseUrl + Urls.getTravelById).replace(queryParameters: queryParameter), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      GetTravel getTravel = GetTravel.fromJson(jsonResponse);
      return Data(data: getTravel, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    return const Data(message: _errorMessage);
  }
}

///DELETE TRAVEL BY ID
Future<http.Response> deleteTravelId(queryParameter) async {
  try {
    return await http.get(
      Uri.parse(Urls.baseUrl + Urls.deleteTravel).replace(queryParameters: queryParameter),
      headers: headers,
    );
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///GET EXPENSE LIST
Future<Data<MyExpenseListModel>> getExpenseListData() async {
  try {
    final response = await http.get(Uri.parse(Urls.baseUrl + Urls.expenseList), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      MyExpenseListModel myExpenseListModel = MyExpenseListModel.fromJson(jsonResponse);
      return Data(data: myExpenseListModel, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    return const Data(message: _errorMessage);
  }
}

///GET EXPENSE FIELD BY ID
Future<Data<ExpenseFieldModel>> getExpenseFieldData() async {
  try {
    final response = await http.get(Uri.parse(Urls.baseUrl + Urls.getExpenseField), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ExpenseFieldModel expenseFieldModel = ExpenseFieldModel.fromJson(jsonResponse);
      return Data(data: expenseFieldModel, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    return const Data(message: _errorMessage);
  }
}

///GET EXPENSE BY ID
Future<Data<GetEmpExpenseModel>> getExpenseDataById(queryParameter) async {
  try {
    final response =
        await http.get(Uri.parse(Urls.baseUrl + Urls.getExpenseById).replace(queryParameters: queryParameter), headers: headers);

    // log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      GetEmpExpenseModel getEmpExpenseModel = GetEmpExpenseModel.fromJson(jsonResponse);
      return Data(data: getEmpExpenseModel, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    log(e);
    return const Data(message: _errorMessage);
  }
}

/*///SAVE EXPENSE
Future<http.StreamedResponse> saveExpense({http.MultipartFile image, Map<String, String> body}) async {
  try {
    final request = http.MultipartRequest('POST', Uri.parse('https://demo.archerhr.com/EmployeeData/SaveExpense'));
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Cookie': kSharedPreferences.getString("Cookie"),
    });
    // if (image != null) {
    //   request.files.add(image);
    // }
    //request.body = json.encode(body);
    request.fields.addAll(body);
    return await request.send();
  } catch (_) {
    log(_.toString());
    return null;
  }
}*/

///SAVE EXPENSE
Future<http.StreamedResponse> saveExpense({Map<String, Object> body}) async {
  try {
    var request = http.Request('POST', Uri.parse(Urls.baseUrl + Urls.saveExpense));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    return await request.send();
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///UPDATE EXPENSE
Future<http.StreamedResponse> updateExpenseList({Map<String, Object> body}) async {
  try {
    var request = http.Request('POST', Uri.parse(Urls.baseUrl + Urls.updateExpenseList));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    return await request.send();
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///DELETE EXPENSE BY ID
Future<http.Response> deleteExpenseId(queryParameter) async {
  try {
    return await http.get(
      Uri.parse(Urls.baseUrl + Urls.deleteExpense).replace(queryParameters: queryParameter),
      headers: headers,
    );
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///DELETE EXPENSE LIST BY ID
Future<http.Response> deleteExpenseListId(queryParameter) async {
  try {
    return await http.get(
      Uri.parse(Urls.baseUrl + Urls.deleteExpenseList).replace(queryParameters: queryParameter),
      headers: headers,
    );
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///GET LEAVE APPROVAL LIST
Future<Data<LeaveApproval>> getLeaveApprovalData() async {
  try {
    final response = await http.get(Uri.parse(Urls.baseUrl + Urls.leaveApprovalList), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      LeaveApproval leaveApproval = LeaveApproval.fromJson(jsonResponse);
      return Data(data: leaveApproval, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    return const Data(message: _errorMessage);
  }
}

///GET TRAVEL APPROVAL LIST
Future<Data<TravelApprovalModel>> getTravelApprovalData() async {
  try {
    final response = await http.get(Uri.parse(Urls.baseUrl + Urls.travelApprovalList), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      TravelApprovalModel travelApproval = TravelApprovalModel.fromJson(jsonResponse);
      return Data(data: travelApproval, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    print(e.toString());
    return const Data(message: _errorMessage);
  }
}

///GET EXPENSE APPROVAL LIST
Future<Data<ExpenseApproval>> getExpenseApprovalData() async {
  try {
    final response = await http.get(Uri.parse(Urls.baseUrl + Urls.expenseApprovalList), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ExpenseApproval expenseApproval = ExpenseApproval.fromJson(jsonResponse);
      return Data(data: expenseApproval, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    return const Data(message: _errorMessage);
  }
}

///STATUS UPDATE LEAVE
Future<http.StreamedResponse> statusLeaveUpdate({Map<String, Object> body}) async {
  try {
    var request = http.Request('POST', Uri.parse(Urls.baseUrl + Urls.statusLeaveApproval));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    return await request.send();
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///STATUS UPDATE TRAVEL
Future<http.StreamedResponse> statusTravelUpdate({Map<String, Object> body}) async {
  try {
    var request = http.Request('POST', Uri.parse(Urls.baseUrl + Urls.statusTravelApproval));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    return await request.send();
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///STATUS UPDATE EXPENSE
Future<http.StreamedResponse> statusExpenseUpdate({Map<String, Object> body}) async {
  try {
    var request = http.Request('POST', Uri.parse(Urls.baseUrl + Urls.statusExpenseApproval));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    return await request.send();
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///GET DASHBOARD GRAPH
Future<Data<DashboardData>> getDashboardData() async {
  try {
    final response = await http.get(Uri.parse(Urls.baseUrl + Urls.dashBoardGraph), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      DashboardData dashboardData = DashboardData.fromJson(jsonResponse);
      return Data(data: dashboardData, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    return const Data(message: _errorMessage);
  }
}

///GET DASHBOARD EMPLOYEE DATA
Future<Data<HomeDetailsModel>> getDashboardEmployeeData() async {
  try {
    final response = await http.get(Uri.parse(Urls.baseUrl + Urls.employeeDashBoardData), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      HomeDetailsModel homeDetailsModel = HomeDetailsModel.fromJson(jsonResponse);
      return Data(data: homeDetailsModel, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    return const Data(message: _errorMessage);
  }
}

///GET PROFILE INFO
Future<Data<ProfileModel>> getProfileData() async {
  try {
    final response = await http.get(Uri.parse(Urls.baseUrl + Urls.profile), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ProfileModel profileModel = ProfileModel.fromJson(jsonResponse);
      return Data(data: profileModel, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    log(e.toString());
    return const Data(message: _errorMessage);
  }
}

///PUNCH IN
Future<Data<PunchModel>> punchIn({Map<String, Object> body}) async {
  try {
    final response = await http.post(Uri.parse(Urls.baseUrl + Urls.punchIn), headers: headers,body: jsonEncode(body));

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      PunchModel punchModel = PunchModel.fromJson(jsonResponse);
      return Data(data: punchModel, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    log(e.toString());
    return const Data(message: _errorMessage);
  }
}

///PUNCH OUT
Future<http.StreamedResponse> punchOut({Map<String, Object> body}) async {
  try {
    var request = http.Request('POST', Uri.parse(Urls.baseUrl + Urls.punchOut));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    return await request.send();
  } catch (_) {
    log(_.toString());
    return null;
  }
}

///DIRECTORY LIST
Future<Data<DirectoryListModel>> directoryListData() async {
  try {
    final response = await http.get(Uri.parse(Urls.baseUrl + Urls.getDirectoryList), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      DirectoryListModel directoryListModel = DirectoryListModel.fromJson(jsonResponse);
      return Data(data: directoryListModel, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    log(e.toString());
    return const Data(message: _errorMessage);
  }
}

///DIRECTORY BY ID
Future<Data<DirectoryByIdModel>> getDirectoryDataById(queryParameter) async {
  try {
    final response =
    await http.get(Uri.parse(Urls.baseUrl + Urls.getDirectoryById).replace(queryParameters: queryParameter), headers: headers);

    log("Response : ${response.body}");
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      DirectoryByIdModel directoryByIdModel = DirectoryByIdModel.fromJson(jsonResponse);
      return Data(data: directoryByIdModel, statusCode: response.statusCode);
    }
    return Data.fromJson(jsonResponse);
  } on SocketException catch (_) {
    return const Data(message: _noInternetConnection);
  } catch (e) {
    log(e);
    return const Data(message: _errorMessage);
  }
}
