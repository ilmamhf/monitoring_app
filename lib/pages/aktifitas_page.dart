import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/grafik_aktifitas.dart';
import '../components/month_picker.dart';
import '../components/my_button.dart';
import '../services/firebase_auth.dart';
import '../services/firestore.dart';
import 'form_aktifitas_page.dart';
import 'histori_aktifitas_page.dart';
import 'histori_harian_aktifitas_page.dart';

class AktifitasFisikPage extends StatefulWidget {
  const AktifitasFisikPage({Key? key}) : super(key: key);

  @override
  State<AktifitasFisikPage> createState() => _AktifitasFisikPageState();
}

class _AktifitasFisikPageState extends State<AktifitasFisikPage> {
  // text editing controllers
  final dateAwalController = TextEditingController();
  final dateAkhirController = TextEditingController();
  final monthController = TextEditingController();

  DateTime? dateAwal;
  DateTime? dateAkhir;
  DateTime selectedMonth = DateTime.now();

  bool historiOnly = false;
  bool searchPerformed = false;
  bool searchSuccess = false;

  int? weekOfMonth;

  // firestore
  final FirestoreService firestoreService = FirestoreService();

  // buat waktu mulai hari dan akhir hari
  DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999, 999);
  }

  DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  void cekData() {
    if (historiOnly == true) {
      int daysInMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;
      DateTime awalBulan = DateTime(selectedMonth.year, selectedMonth.month, 1);
      DateTime akhirBulan = DateTime(selectedMonth.year, selectedMonth.month, daysInMonth);

      print(awalBulan.toString() + akhirBulan.toString());
      // Update dateAwal dan dateAkhir
      setState(() {
        dateAwal = awalBulan;
        dateAkhir = akhirBulan;
        selectedMonth = selectedMonth;
        historiOnly = false;
        searchPerformed = false;
        searchSuccess = false;
      });

      return;
    }

    if (monthController.text != '') {
      int daysInMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;
      DateTime awalBulan = DateTime(selectedMonth.year, selectedMonth.month, 1);
      DateTime akhirBulan = DateTime(selectedMonth.year, selectedMonth.month, daysInMonth);

      print(awalBulan.toString() + akhirBulan.toString());
      // Update dateAwal dan dateAkhir
      setState(() {
        dateAwal = awalBulan;
        dateAkhir = akhirBulan;
        selectedMonth = selectedMonth;
        searchSuccess = true;
        searchPerformed = false;
      });
    } else {
      setState(() {
        searchPerformed = false;
        searchSuccess = false;
      });

      // Show error message if parsing fails
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Format tanggal tidak valid'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  TextSpan buildDailyTextSpan(int day, int durasiAKB, int durasiAKS) {
    // Membuat TextSpan untuk satu hari
    return TextSpan(
      text: '\nHari ke-$day: Aktifitas sedang $durasiAKS menit, Aktifitas berat $durasiAKB menit\n',
      style: TextStyle(color: Colors.black, fontSize: 14), // Sesuaikan gaya teks sesuai kebutuhan
    );
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 9, 53, 147),
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 52, 79, 255),
        backgroundColor: Color.fromARGB(255, 9, 53, 147),
        title: Text(
          'HISTORI AKTIFITAS FISIK\nGeMileActive', 
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: (size.height/12) / 3 - 3,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          MonthPicker(
            text: 'Bulan dan Tahun',
            labelColor: Colors.white,
            monthController: monthController,
            selectedMonth: selectedMonth,
            onMonthChanged: (newMonth) { // Fungsi callback untuk memperbarui selectedMonth
            setState(() {
              selectedMonth = newMonth;
              searchPerformed = false;
            });
          },
          ),
          
          const SizedBox(height: 20),

          MyButton(
            onTap: () {
              
              // // Parse date strings from controllers to DateTime objects
              // DateTime? parsedMonth =
              //     DateTime.tryParse(monthController.text);
              
              // print(parsedMonth);
              // print(selectedMonth);

              // Check if parsing successful
              cekData();

              // Set searchPerformed to true when search button is pressed
              setState(() {
                searchPerformed = true;
              });
            },
            text: 'Cari',
            size: 25,
          ),
          const SizedBox(height: 20),
          MyButton(
            onTap: () {
              historiOnly = true;
              searchPerformed = false;

              // Check if parsing successful
              cekData();

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HistoriAktifitasPage(
                          dateAwal: dateAwal,
                          dateAkhir: dateAkhir,
                        )));
            },
            text: 'Lihat detail histori',
            size: 10,
          ),
          const SizedBox(height: 20),

          // ngambil data buat grafik
          if (searchPerformed && searchSuccess && dateAwal != null && dateAkhir != null)
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(
                      'aktifitas fisik_${FirebaseAuth.instance.currentUser!.uid}')
                  .where('timestamp', isGreaterThanOrEqualTo: dateAwal != null ? Timestamp.fromDate(startOfDay(dateAwal!)) : null)
                  .where('timestamp', isLessThanOrEqualTo: dateAkhir != null ? Timestamp.fromDate(endOfDay(dateAkhir!)) : null)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("Histori kosong"));
                } else {
                  // // sekarang week ke brp
                  // weekCheck();

                  // cari total hari
                  int daysInMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;
                  List<int> patokanTanggal = [7, 14, 21, 28, 31]; // patokan utk cek timestamp
                  List<int> total = [];
                  List<String> labelMingguan = [];
                  
                  // bagi jadi 4 - 5 minggu
                  for (int i = 0; i <= (daysInMonth/7).ceil() - 1; i++) {
                    // tiap minggu ngapain
                    total.add(0); // nambah item ke list
                    labelMingguan.add('Minggu ke-${i+1}'); // nambah label sesuai jumlah minggu
                    for (int j = 0; j < snapshot.data!.docs.length; j++) {
                      // cek doc tsb ada di minggu berapa
                      Timestamp timestamp = snapshot.data!.docs[j]['timestamp'];
                      if (patokanTanggal[i] == 31) { // khusus minggu terakhir
                        if (timestamp.toDate().day <= patokanTanggal[i] && timestamp.toDate().day > 28) {
                          // di minggu i, totalnya nambah
                          total[i] += 0 + snapshot.data!.docs[j]['Poin'] as int;
                        }
                      } else if (timestamp.toDate().day <= patokanTanggal[i] && timestamp.toDate().day > patokanTanggal[i] - 7) {
                        // di minggu i, totalnya nambah
                        total[i] += 0 + snapshot.data!.docs[j]['Poin'] as int;
                      }
                    }
                  }

                  // Inisialisasi list durasiAKB dan durasiAKS
                  List<int> durasiAKB = List.filled(daysInMonth+1, 0);
                  List<int> durasiAKS = List.filled(daysInMonth+1, 0);

                  // Perulangan untuk mengisi durasi aktifitas berat (AKB) dan sedang (AKS)
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    Timestamp timestamp = snapshot.data!.docs[i]['timestamp'];
                    int day = timestamp.toDate().day; // Adjustment to match the list index
                    print(day);
                    
                    String tingkatAktifitas = snapshot.data!.docs[i]['Tingkat Aktifitas'];
                    int durasi = snapshot.data!.docs[i]['Durasi'] as int;
                    
                    if (tingkatAktifitas == 'Aktifitas berat') {
                      durasiAKB[day] += 0 + durasi;
                    } else if (tingkatAktifitas == 'Aktifitas sedang') {
                      durasiAKS[day] += 0 + durasi;
                    }
                  }
                  

                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text.rich(
                                TextSpan(
                                  children: <TextSpan>[
                                  TextSpan(text: 'Berikut adalah grafik perkembangan aktifitas kamu di bulan '),
                                  
                                  TextSpan(text: '${monthController.text}', style: const TextStyle(fontWeight: FontWeight.bold),),
                                ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      
                          Container(
                            height: 200,
                            width: size.width,
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: AktifitasLineChart(total, labelMingguan),
                            ),
                          ),

                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text.rich(
                                    TextSpan(
                                      children: <TextSpan>[
                                      const TextSpan(text: 'Berikut adalah resume hasil aktifitas kamu di bulan ', style: TextStyle(fontSize: 16),),
                                      
                                      TextSpan(text: '${monthController.text}\n', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                  
                                      for (int i = 1; i <= 7; i++)... [ // minggu 1
                                        buildDailyTextSpan(i, durasiAKB[i], durasiAKS[i]),
                                      ],
                                      for (int i = 8; i <= 14; i++)... [ // minggu 2
                                        buildDailyTextSpan(i, durasiAKB[i], durasiAKS[i]),
                                      ],
                                      for (int i = 15; i <= 21; i++)... [ // minggu 3
                                        buildDailyTextSpan(i, durasiAKB[i], durasiAKS[i]),
                                      ],
                                  
                                      if (daysInMonth == 28)... [ // minggu 4 & 5
                                        for (int i = 22; i <= 28; i++)... [
                                          buildDailyTextSpan(i, durasiAKB[i], durasiAKS[i]),
                                        ],
                                      ] else... [
                                        for (int i = 22; i <= 28; i++)... [
                                          buildDailyTextSpan(i, durasiAKB[i], durasiAKS[i]),
                                        ],
                                        for (int i = 29; i <= daysInMonth; i++)... [
                                          buildDailyTextSpan(i, durasiAKB[i], durasiAKS[i]),
                                        ],
                                      ]
                                      
                                  
                                  
                                    ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            )
        ],
      ),
      floatingActionButton: !loginCheck()
          ? Container()
          : FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FormAktifitasPage())),
              child: const Icon(
                Icons.add,
              )
            ),
    );
  }
}
