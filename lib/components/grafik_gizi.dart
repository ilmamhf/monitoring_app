import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class IMTLineChart extends StatelessWidget {
  final List<double> imtValues;
  final List<Timestamp> dates;

  IMTLineChart(this.imtValues, this.dates);

  LineChartBarData garis(double value, Color warna) {
    return LineChartBarData(
      spots: [FlSpot(0, value), FlSpot(imtValues.length - 1, value)],
      isCurved: false,
      color: warna,
      barWidth: 2,
      dotData: FlDotData(show: false)
    );
  }

  @override
  Widget build(BuildContext context) {
  // Balikkan urutan data
  List<double> reversedIMTValues = imtValues.reversed.toList();
  List<Timestamp> reversedDates = dates.reversed.toList();

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < reversedIMTValues.length; i++)
                FlSpot(i.toDouble(), double.parse(reversedIMTValues[i].toStringAsFixed(1))),
            ],
            isCurved: false,
            color: Colors.blue,
            barWidth: 5,
            dotData: FlDotData(show: false)
          ),
          // Sangat Kurus
          garis(17, Colors.red),
          // Kurus
          garis(18.5, Colors.green),
          // Normal
          garis(25, Colors.orange),
          // Gizi lebih
          garis(27, Colors.red)
          // Obesitas
        ],
        titlesData: FlTitlesData(
          // sb x bawah
          bottomTitles: AxisTitles( 
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1, // Atur interval sesuai kebutuhan Anda
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                return Text(reversedDates[value.toInt()].toDate().toLocal().toString().split(" ")[0], style: TextStyle(fontSize: 12),); // Label dimulai dari 1
              },
            ),
          ),
          // sb x atas
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

          // sb y kiri
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

          // sb y kanan
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      )
    );
  }
}
