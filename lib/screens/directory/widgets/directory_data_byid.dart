import 'package:archerhr_mobile/const/const_size.dart';
import 'package:archerhr_mobile/provider/directory_data_byid_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectoryDataById extends StatefulWidget {
  DirectoryDataById({Key key, this.id}) : super(key: key);
  int id;

  @override
  _DirectoryDataByIdState createState() => _DirectoryDataByIdState();
}

class _DirectoryDataByIdState extends State<DirectoryDataById> {
  GetDirectoryByIdProvider getDirectoryByIdProvider;
  String name, designation, email, mobileNo, aboutMe;

  @override
  void initState() {
    super.initState();
    getDirectoryByIdProvider = Provider.of<GetDirectoryByIdProvider>(context, listen: false);
    getDirectoryById();
  }

  getDirectoryById() async {
    await getDirectoryByIdProvider.getDirectoryListByIdData(context, widget.id);

    name = getDirectoryByIdProvider.employeeDetails.firstName + " " + getDirectoryByIdProvider.employeeDetails.lastName;
    designation = getDirectoryByIdProvider.employeeDetails.desg == null
        ? " "
        : getDirectoryByIdProvider.employeeDetails.desg + " - " + getDirectoryByIdProvider.employeeDetails.dept;
    email = getDirectoryByIdProvider.employeeDetails.priEmail == null ? "" : getDirectoryByIdProvider.employeeDetails.priEmail;
    mobileNo = getDirectoryByIdProvider.employeeDetails.mobileno == null ? "" : getDirectoryByIdProvider.employeeDetails.mobileno;
    aboutMe = getDirectoryByIdProvider.employeeDetails.aboutMe == null ? "" : getDirectoryByIdProvider.employeeDetails.aboutMe;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetDirectoryByIdProvider>(builder: (context, provider, child) {
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
        titlePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    provider.clear();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (provider.loading)
                  const CircularProgressIndicator()
                else
                  Form(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/images/baby.jpeg",
                              width: 150.w,
                              height: 150.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        sizeBox20h,
                        Text(
                          name,
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        sizeBox10h,
                        Text(
                          designation,
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
                        ),
                        sizeBox10h,
                        Text(
                          email,
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
                        ),
                        sizeBox10h,
                        GestureDetector(
                            onTap: () async{
                              launch('tel://$mobileNo');
                            },
                            child: Text(
                              mobileNo,
                              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300, color: Colors.cyan),
                            )),
                        sizeBox10h,
                        Text(
                          aboutMe,
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
