class Urls {
  // App's base url
  static const String baseUrl = 'https://demo.archerhr.com';

///AUTHENTICATION
  // Login url
  static const String login = '/api/auth/login';

///CHANGE PASSWORD
  // Change password url
  static const String changePassword = '/api/auth/ChangePassword';

///PROFILE
  // profile url
  static const String profile = '/EmployeeData/GetEmpMyProfile';

///LEAVE
  // Get leave url
  static const String getLeave = '/EmployeeData/GetEmpLeaveData';

  // Save leave url
  static const String saveLeave = '/EmployeeData/SaveLeave';

  // Update leave url
  static const String updateLeave = '/EmployeeData/UpdateLeave';

  // Get leave by id url
  static const String getLeaveById = '/EmployeeData/GetLeave';

  // Delete leave url
  static const String deleteLeave = '/EmployeeData/DeleteLeave';

///TRAVEL
  // Get Travel Field url
  static const String getFieldTravel = '/EmployeeData/GetTravelFields';

  // Get Travel List url
  static const String travelList = '/EmployeeData/MyTravelList';

  // Save & Update Domestic Travel url
  static const String addUpdateDomesticTravel = '/EmployeeData/SaveNewdom';

  // Save & Update International Travel url
  static const String addUpdateInternationalTravel = '/EmployeeData/SaveNewint';

  // Get Travel By Id url
  static const String getTravelById = '/EmployeeData/GetEmpTravel';

  // Delete Travel url
  static const String deleteTravel = '/EmployeeData/DeleteTravel';

///EXPENSE

  // Expense List url
  static const String expenseList = '/EmployeeData/MyExpenseList';

  // Get Expense Field
  static const String getExpenseField = '/EmployeeData/GetExpenseFields';

  // Get Expense By Id
  static const String getExpenseById = '/EmployeeData/GetEmpExpense';

  // Save Expense
  static const String saveExpense = '/EmployeeData/SaveExpense';

  // Get ExpenseList By Id
  static const String getExpenseListById = '/EmployeeData/GetExpenseDetails';

  // Update ExpenseList
  static const String updateExpenseList = '/EmployeeData/EditExpenseList';

  // Delete Expense
  static const String deleteExpense = '/EmployeeData/DeleteExpense';

  //Delete Expense List
  static const String deleteExpenseList = '/EmployeeData/DeleteExpenseList';

///APPROVAL

  //Leave Approval List
  static const String leaveApprovalList = '/EmployeeData/MyAprLeaveData';

  //Travel Approval List
  static const String travelApprovalList = '/EmployeeData/MgrTravelAprData';

  //Expense Approval List
  static const String expenseApprovalList = '/EmployeeData/MyAprlReqExpenseData';

///STATUS

  //Leave Status Approval
  static const String statusLeaveApproval = '/EmployeeData/AprLeave';

  //Travel Status Approval
  static const String statusTravelApproval = '/EmployeeData/ApproveTravel';

  //Expense Status Approval
  static const String statusExpenseApproval = '/EmployeeData/ApproveExpense';

///DASHBOARD
  //Dashboard Data
  static const String dashBoardGraph = '/Dashboard/GetHomeDashboard';

  //Employee Dashboard Data
  static const String employeeDashBoardData = '/EmployeeData/GetHomeDashboard';

///PUNCH
  //Punch In
  static const String punchIn = '/EmployeeData/Punchin';

  //Punch Out
  static const String punchOut = '/EmployeeData/Punchout';

  //Punch Get
  static const String punchGet = '/EmployeeData/Punchget';

///DIRECTORY
  //Get Directory
  static const String getDirectoryList = '/EmployeeData/GetAllEmplist';

  //Get Directory By Id
  static const String getDirectoryById = '/EmployeeData/GetEmpDet';
}