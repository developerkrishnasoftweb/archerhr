import 'package:archerhr_mobile/screens/company/widgets/about_company.dart';
import 'package:archerhr_mobile/screens/company/widgets/directory_company.dart';
import 'package:archerhr_mobile/screens/company/widgets/holidays_company.dart';
import 'package:archerhr_mobile/screens/company/widgets/news_announcement_company.dart';
import 'package:archerhr_mobile/screens/company/widgets/policies_company.dart';
import 'package:archerhr_mobile/utils/services/palette.dart';
import 'package:flutter/material.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({Key key}) : super(key: key);

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appBackground,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Palette.appBarColor,
      ),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            Container(
              color: Palette.expenseTabBar,
              child: const TabBar(
                labelColor: Colors.white,
                isScrollable: true,
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                  color: Palette.selectedExpenseTabBar,
                ),
                tabs: [
                  Tab(text: 'NEWS & ANNOUNCEMENT'),
                  Tab(text: 'HOLIDAYS'),
                  Tab(text: 'POLICIES'),
                  Tab(text: 'DIRECTORY'),
                  Tab(text: 'ABOUT COMPANY'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(children: [
                AnnouncementCompanyScreen(),
                HolidaysCompanyScreen(),
                PoliciesCompanyscreen(),
                DirectoryCompanyScreen(),
                AboutCompanyScreen()
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
