import 'dart:developer';
import 'dart:io';

import 'package:archerhr_mobile/const/const_function.dart';
import 'package:archerhr_mobile/const/const_global.dart';
import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/expense_data_provider.dart';
import 'package:archerhr_mobile/provider/expense_list_data_provider.dart';
import 'package:archerhr_mobile/provider/get_expense_provider.dart';
import 'package:archerhr_mobile/screens/auth/login/login_screen.dart';
import 'package:archerhr_mobile/screens/widgets/input.dart';
import 'package:archerhr_mobile/screens/widgets/title_text.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:archerhr_mobile/utils/services/rest_apis.dart';
import 'package:archerhr_mobile/utils/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FixedAllowanceScreen extends StatefulWidget {
  FixedAllowanceScreen({Key key, this.id, this.expenseDataProvider, this.expenseListDataProvider}) : super(key: key);
  ExpenseDataProvider expenseDataProvider;
  ExpenseListDataProvider expenseListDataProvider;
  int id;

  @override
  _FixedAllowanceScreenState createState() => _FixedAllowanceScreenState();
}

class _FixedAllowanceScreenState extends State<FixedAllowanceScreen> {
  int categoryDropdownValue;
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  List<File> _imageList = [];
  File selectedImage;
  List<XFile> selectedImageList = [];
  MultipartFile uploadImage;

  ExpenseDataProvider expenseDataProvider;
  ExpenseListDataProvider expenseListDataProvider;
  GetExpenseProvider getExpenseProvider;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController perDayController = TextEditingController();
  TextEditingController noOfDaysController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController fileController = TextEditingController();

  void selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final tempFile = File(pickedFile.path);
      final fileSize = await tempFile.length();
      if (fileSize < 2097152) {
        setState(() {
          selectedImage = tempFile;
        });
      } else {
        Utils.showToast('File size supported up to 2MB');
      }
    }
    print(selectedImage.path.toString());
    if (selectedImage.path.isNotEmpty) {
      _imageList.add(selectedImage);
    }
    setState(() {});
  }

/*  Future<void> selectMultiImage() async {
    selectedImageList = await _picker.pickMultiImage();
    if (selectedImageList.isNotEmpty) {
      _imageList.addAll(selectedImageList);
    }
    setState(() {});
  }*/

  dateTap(BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('MM-dd-yyyy').format(picked);
      if (fromDateController.text.isNotEmpty && toDateController.text.isNotEmpty) {
        noOfDaysController.text = DateFormat("MM-dd-yyyy")
            .parse(toDateController.text)
            .difference(DateFormat("MM-dd-yyyy").parse(fromDateController.text))
            .inDays
            .toString();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    expenseDataProvider = widget.expenseDataProvider;
    expenseListDataProvider = widget.expenseListDataProvider;
    getExpenseProvider = Provider.of<GetExpenseProvider>(context, listen: false);
    getExpenseProvider.getExpenseData(context, widget.id);
  }

/*  @override
  void dispose() {
    super.dispose();
    expenseListDataProvider.clear();
    expenseDataProvider.clear();
  }*/

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Category :",
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        child: DropdownButton<int>(
                          isExpanded: true,
                          icon: const SizedBox(),
                          hint: const Text("Choose Category"),
                          value: categoryDropdownValue,
                          underline: const SizedBox(),
                          items: expenseDataProvider.expenseType.where((category) => category.catId == 1).map((categoryList) {
                            return DropdownMenuItem(
                              child: Text(categoryList.name),
                              value: categoryList.id,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              categoryDropdownValue = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                sizeBox10w,
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Name :",
                      ),
                      Input(
                        controller: nameController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizeBox20h,
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "From Date :",
                      ),
                      Input(
                        controller: fromDateController,
                        readOnly: true,
                        onTap: () => dateTap(context, fromDateController),
                      ),
                    ],
                  ),
                ),
                sizeBox10w,
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "To Date :",
                      ),
                      Input(
                        controller: toDateController,
                        readOnly: true,
                        onTap: () => dateTap(context, toDateController),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizeBox20h,
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "No of Days :",
                      ),
                      Input(
                        controller: noOfDaysController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          amountController.text =
                              ((int.tryParse(value) ?? 0) * (int.tryParse(perDayController.text) ?? 0)).toString();
                        },
                      ),
                    ],
                  ),
                ),
                sizeBox10w,
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Per Day :",
                      ),
                      Input(
                        controller: perDayController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          amountController.text =
                              ((int.tryParse(noOfDaysController.text) ?? 0) * (int.tryParse(value) ?? 0)).toString();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizeBox20h,
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Total Amount :",
                      ),
                      Input(
                        controller: amountController,
                        readOnly: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizeBox20h,
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const TitleText(
                        label: "Comments :",
                      ),
                      Input(
                        controller: commentController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            /*  sizeBox20h,
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const TitleText(
                            label: "Upload File :",
                          ),
                          sizeBox5w,
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.r),
                                color: Colors.grey,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  selectImage();
                                  //selectMultiImage();
                                },
                                child: const Text(
                                  'Choose File',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      sizeBox5h,
                      GridView.builder(
                        //scrollDirection: Axis.vertical,
                          padding: EdgeInsets.zero,
                         // physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemCount: _imageList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.file(
                                    File(_imageList[index].path),
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    right: -4,
                                    top: -4,
                                    child: Container(
                                      color: const Color.fromRGBO(255, 255, 244, 0.7),
                                      child: IconButton(
                                        onPressed: () {
                                          _imageList.removeAt(index);
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.delete),
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),*/
            sizeBox30h,
            Center(
              child: Container(
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  color: Palette.buttonBackgroundColor,
                ),
                child: TextButton(
                  onPressed: _saveExpense,
                  child: isLoading == false
                      ? Text(
                          'ADD',
                          style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        )
                      : const CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveExpense() async {
    if (categoryDropdownValue != null &&
        nameController.text.isNotEmpty &&
        fromDateController.text.isNotEmpty &&
        toDateController.text.isNotEmpty &&
        perDayController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        commentController.text.isNotEmpty) {
      Utils.unFocus(context);
      isLoading = true;

      final expenseJson ={
        "TypeId": categoryDropdownValue,
        "ExpenseName": nameController.text,
        "FromDate": fromDateController.text,
        "ToDate": toDateController.text,
        "Rate": perDayController.text,
        "Amount": amountController.text,
        "Comments": commentController.text,
      };

      if (widget.id != null) {
        expenseJson.addAll({"ExpenseId": widget.id.toString()});
      }

      final response = await saveExpense(body: expenseJson);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return buildSingleButtonPopupDialog(
                  context: context,
                  icon: Icons.check_circle_outline_rounded,
                  mainText: "Saved!",
                  text: "Claim Successfully Saved.",
                  onPressed: () {
                    Navigator.pop(context);
                    getExpenseProvider.clear();
                    getExpenseProvider.getExpenseData(context, widget.id);
                    expenseListDataProvider.clear();
                    expenseDataProvider.clear();
                    expenseListDataProvider.getEmpExpenseData(context);
                  });
            });
      } else if (response.statusCode == 404) {
        Navigator.pop(context);
        unAuthenticationDialog(context);
      } else {
        log(response.reasonPhrase);
      }
      isLoading = false;
    } else {
      Utils.showToast("Please enter detail");
    }
  }

/*  _saveExpense() async {
    if (categoryDropdownValue != null &&
        nameController.text.isNotEmpty &&
        fromDateController.text.isNotEmpty &&
        toDateController.text.isNotEmpty &&
        perDayController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        commentController.text.isNotEmpty
        */ /*&& selectedImage.path.isNotEmpty*/ /*) {
      Utils.unFocus(context);
      // isLoading = true;

      if (selectedImage != null) {
        uploadImage = MultipartFile.fromBytes(
            'FilePath', selectedImage.readAsBytesSync(),
            filename: selectedImage.path.split(Platform.pathSeparator).last);
      }

      final expenseJson = <String, String>{
        "TypeId": categoryDropdownValue.toString(),
        "ExpenseName": nameController.text,
        "FromDate": fromDateController.text,
        "ToDate": toDateController.text,
        "Rate": perDayController.text,
        "Amount": amountController.text,
        "Comments": commentController.text,
        */ /*"FilePath": selectedImage.path*/ /*
      };

      final response = await saveExpense(image: uploadImage,body: expenseJson);
      print(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return buildSingleButtonPopupDialog(
                  context: context,
                  icon: Icons.check_circle_outline_rounded,
                  mainText: "Saved!",
                  text: "Claim Successfully Saved.",
                  onPressed: () {
                    Navigator.pop(context);
                    expenseListDataProvider.clear();
                    expenseListDataProvider.getEmpExpenseData(context);
                  });
            });
      } else if (response.statusCode == 404) {
        Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return buildSingleButtonPopupDialog(
                  icon: Icons.warning_amber_rounded,
                  iconColor: Colors.red,
                  mainText: "Unauthenticated!",
                  text: "Authentication failed,please login again",
                  onPressed: () {
                    kSharedPreferences.clear();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  });
            });
      } else {
        log(response.reasonPhrase);
      }
      isLoading = false;
    } else {
      Utils.showToast("Please enter detail");
    }
  }*/
}
