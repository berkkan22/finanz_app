import 'package:finanz_app/core/globals.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import 'models/pie_data.dart';

List<PieChartSectionData> getSections(List<Data> data) => data
    .asMap()
    .map<int, PieChartSectionData>((key, data) {
      final value = PieChartSectionData(
        color: data.color,
        value: data.percent,
        title: data.percent.toStringAsFixed(2),
        radius: 25,
        titleStyle: const TextStyle(
          fontSize: 14,
          color: white,
        ),
      );

      return MapEntry(key, value);
    })
    .values
    .toList();
