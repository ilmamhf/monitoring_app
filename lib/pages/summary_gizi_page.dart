import 'package:flutter/material.dart';

import '../components/my_button.dart';

class SummaryGizi extends StatelessWidget {
  final double beratBadan;
  final double tinggiBadan;
  final double IMT;
  final String kategoriIMT;

  const SummaryGizi({
    super.key, 
    required this.beratBadan, 
    required this.tinggiBadan, 
    required this.IMT, 
    required this.kategoriIMT
  });

  Widget giziOutput(String teks, int bintang) {
    return Column(children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      for (int i = 0; i < bintang; i++)
      Icon(Icons.star)],),
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
              child: Text("Hasil Status Gizi Anda", 
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          
            const SizedBox(height: 20),

            // penjelasan

            if (kategoriIMT == "Sangat Kurus") ...[
              giziOutput("Waduh sepertinya kamu harus banyakin makan makanan yang bergizi nih!", 1)
            ] else if (kategoriIMT == "Kurus") ...[
              giziOutput("Hasil IMT kamu sedikit lagi bagus nih! tinggal usahain makan makanan yang lebih sehat!", 2)
            ] else if (kategoriIMT == "Normal") ...[
              giziOutput("Wah hasil IMT kamu normal! artinya pola makan kamu udah bagus, pertahanin!", 3)
            ] else if (kategoriIMT == "Gizi Lebih") ...[
              giziOutput("Anjay bergizi lebih", 4)
            ] else ...[
              giziOutput("Diet bro", 1)
            ],

            const SizedBox(height: 20),

            // hasil gizi
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.blue,
                  ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Text(
                    """Berat Badan : $beratBadan kg
                    \nTinggi Badan : $tinggiBadan cm
                    \nNilai IMT : ${IMT.toStringAsFixed(1)}
                    \nKategori IMT : $kategoriIMT"""
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