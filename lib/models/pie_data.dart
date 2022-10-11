import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(type: 0, percent: 30, color: Colors.green),
    Data(type: 0, percent: 60, color: Colors.red),
  ];
}

class Data {
  final int type;

  final double percent;

  final Color color;

  Data({required this.type, required this.percent, required this.color});
}
