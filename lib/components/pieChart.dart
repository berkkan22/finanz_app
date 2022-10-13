import 'package:finanz_app/models/pie_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../pie_chart_sections.dart';

class Chart extends StatefulWidget {
  final List data;
  const Chart({Key? key, required this.data}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    List<Data> pieData = []; //widget.data.map((e) {
    //   return Data(type: 0, percent: (100 / e[0] * e[1]), color: Colors.green);
    // }).toList();

    for (var i = 1; i < widget.data.length; i++) {
      pieData.add(
        Data(
          type: 0,
          percent: (100 / widget.data[0] * widget.data[i]),
          color: i == 1 ? Colors.green : Colors.red,
        ),
      );
    }
    return SizedBox(
      child: PieChart(
        PieChartData(
          sections: getSections(pieData),
        ),
      ),
    );
  }
}
