import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../pie_chart_sections.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PieChart(
        PieChartData(
          sections: getSections(),
        ),
      ),
    );
  }
}
