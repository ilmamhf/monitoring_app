import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class IMTLineChart extends StatelessWidget {
  final List<double> imtValues;

  IMTLineChart(this.imtValues);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < imtValues.length; i++)
                FlSpot(i.toDouble(), imtValues[i]),
            ],
            isCurved: false,
            color: Colors.blue,
            barWidth: 5,
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles( 
            sideTitles: SideTitles(
            showTitles: true,
            interval: 1, // Atur interval sesuai kebutuhan Anda
            reservedSize: 22,
            getTitlesWidget: (value, meta) {
              return Text((value.toInt() + 1).toString()); // Label dimulai dari 1
            },
          ),
        ),
      ),
      ),
    );
  }
}