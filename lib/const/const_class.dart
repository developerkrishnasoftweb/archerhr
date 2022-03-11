import 'package:flutter/material.dart';

class Claim {
  final String month;
  final int value;
  final Color colorValue;

  Claim(this.month, this.value, this.colorValue);
}

class LineAttendance {
  final int day;
  final int value;

  LineAttendance(this.day, this.value);
}

class SalesData {
  SalesData(this.year, this.sales, this.segmentColor);

  final String year;
  final double sales;
  final Color segmentColor;
}

class SalesDataPie {
  SalesDataPie(this.year, this.sales);

  final String year;
  final int sales;
}

class Category {
  String name;
  IconData icon;

  Category(this.name, this.icon);
}
