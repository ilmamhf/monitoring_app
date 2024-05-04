import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AktifitasLineChart extends StatelessWidget {
  final List<int> poinPerMinggu;
  final List<String> labels;

  AktifitasLineChart(this.poinPerMinggu, this.labels);

  LineChartBarData garis(double value, Color warna) {
    return LineChartBarData(
      spots: [FlSpot(0, value), FlSpot(poinPerMinggu.length - 1, value)],
      isCurved: false,
      color: warna,
      barWidth: 2,
      dotData: FlDotData(show: false)
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < poinPerMinggu.length; i++)
                FlSpot(i.toDouble(), poinPerMinggu[i].toDouble()),
            ],
            isCurved: false,
            color: Colors.blue,
            barWidth: 5,
            dotData: FlDotData(show: false)
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles( 
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1, 
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                return Text(labels[value.toInt()], style: TextStyle(fontSize: 12)); 
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),

        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: true),
        lineTouchData: LineTouchData(enabled: false),
      ),
    );
  }
}
