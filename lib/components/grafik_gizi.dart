import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IMTLineChart extends StatelessWidget {
  final List<double> imtValues;
  final List<Timestamp> dates;

  IMTLineChart(this.imtValues, this.dates, {super.key});

  LineChartBarData garis(double nilaiY, Color warna) {
    return LineChartBarData(
      spots: [
        if (imtValues.length < 2)... [
          FlSpot(0, nilaiY), FlSpot(1, nilaiY),]
        else
          FlSpot(0, nilaiY), FlSpot(imtValues.length - 1, nilaiY)],
      isCurved: false,
      color: warna,
      barWidth: 2,
      dotData: FlDotData(show: false),
      
    );
  }

  final List<double> nilaiKategoriIMT = [15, 17.75, 20.25, 23.25, 26, 30];
  final List<String> kategori = ['Sangat Kurus', 'Kurus', 'Normal/Ideal', 'Normal/Ideal', 'Gizi Lebih', 'Obesitas'];
  

  @override
  Widget build(BuildContext context) {
  // Balikkan urutan data
  List<double> reversedIMTValues = imtValues.reversed.toList();
  List<Timestamp> reversedDates = dates.reversed.toList();

   // Buat objek DateFormat untuk mengubah format tanggal
  final dateFormat = DateFormat('dd-MM-yyyy');

   Size size = MediaQuery.of(context).size;

    return LineChart(
      LineChartData(
        clipData: FlClipData.all(),
        // bentuk grafik
        minY: 12,
        maxY: 33,
        lineBarsData: [
          
          // data x axis
          LineChartBarData(
            spots: [
              if (imtValues.length < 2)... [
                FlSpot(0, double.parse(reversedIMTValues[0].toStringAsFixed(1))),
                FlSpot(1, double.parse(reversedIMTValues[0].toStringAsFixed(1)))
                ]
              else
              for (int i = 0; i < reversedIMTValues.length; i++)
                FlSpot(i.toDouble(), double.parse(reversedIMTValues[i].toStringAsFixed(1))),
            ],
            isCurved: false,
            color: Colors.blue,
            barWidth: 5,
            dotData: FlDotData(show: false),
          ),

          // // data y axis
          LineChartBarData(
            spots: [
              FlSpot(1, 0), // biar minimal ada 2 titik x
              for (int i = 0; i < nilaiKategoriIMT.length; i++)
                FlSpot(0, nilaiKategoriIMT[i]),
            ],
            isCurved: false,
            color: Colors.blue,
            barWidth: 5,
            show: false,
            dotData: FlDotData(show: false)
          ),


          // Sangat Kurus
          garis(17, Colors.red),
          // Kurus
          garis(18.5, Colors.red),
          // Normal
          garis(21.75, Colors.green),
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
                if (value < 2) { // kalo cuma 1 biar ttp ada garis
                  return  Text(dateFormat.format(reversedDates[(0).toInt()].toDate()), 
                            style: TextStyle(fontSize: 12),
                        ); // Label cuma 1 tp jd 2
                } else {
                  return  Text(dateFormat.format(reversedDates[(value).toInt()].toDate()), 
                            style: TextStyle(fontSize: 12),
                        ); // Label dimulai dari 1
                }
              },
            ),
          ),
          // sb x atas
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

          // sb y kiri
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 0.25,
              reservedSize: size.width/6 + 5,
              getTitlesWidget: (value, meta) {
                for (int i = 0; i < nilaiKategoriIMT.length; i++) {
                  if (value == nilaiKategoriIMT[i]) {
                    return Text(kategori[i], style: TextStyle(fontSize: 12));
                  }
                }
                return Text(''); // Jika di luar jangkauan, kembalikan string kosong
              },
            ),
          ),
          
          // sb y kanan
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),

      gridData: FlGridData(
        show: false
      ),
      
      borderData: FlBorderData(show: true),

      lineTouchData: LineTouchData(
        enabled: false,
      ),

      ),
      
    );
  }
}
