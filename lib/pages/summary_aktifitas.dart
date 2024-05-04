import 'package:flutter/material.dart';

import '../components/my_button.dart';

class SummaryAktifitas extends StatelessWidget {
  final String tingkatAktifitas;
  final String jenisAktifitas;
  final int duration;
  final int poin;

  const SummaryAktifitas({
    super.key, 
    required this.tingkatAktifitas, 
    required this.jenisAktifitas, 
    required this.duration, 
    required this.poin
  });

  Widget aktifitasOutput(String teks, int bintang) {
    return Column(children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      for (int i = 0; i < bintang; i++)
      const Icon(Icons.star)],),
    Text(teks, textAlign: TextAlign.center,)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text("Hasil Aktifitas Fisik Anda", 
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          
            const SizedBox(height: 20),

            // penjelasan

            

            if (poin == 0) ...[
              aktifitasOutput("Waduh, sepertinya kamu harus lebih banyak beraktifitas!", 1)
            ] else ...[
              aktifitasOutput("Semangat! Tambah lagi aktifitas fisik kamu!", 5)
            ],

            const SizedBox(height: 20),

            // hasil aktifitas
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.blue,
                  ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Text(
                    """Tingkat Aktifitas : $tingkatAktifitas
                    \nJenis AKtifitas : $jenisAktifitas
                    \nDurasi : $duration menit
                    \nNilai Aktifitas Harian: $poin poin"""
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // tombol kembali
            MyButton(
              onTap: () {
              // back
              Navigator.pop(context);
              Navigator.pop(context);
            }, text: 'Ok', size: 20,)
          ],
        ),
      ),
    );
  }
}