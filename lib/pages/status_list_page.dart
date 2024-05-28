import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/date_picker.dart';
import '../components/grafik_gizi.dart';
import '../components/my_button.dart';
import '../services/firebase_auth.dart';
import '../services/firestore.dart';
import 'form_status_gizi.dart';
import 'histori_gizi_page.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  // text editing controllers
  final dateAwalController = TextEditingController();
  final dateAkhirController = TextEditingController();

  DateTime? dateAwal;
  DateTime? dateAkhir;
  bool historiOnly = false;

  // firestore
  final FirestoreService firestoreService = FirestoreService();

  // delete message popup
  void showDeleteMessage(docID) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Apakah kamu yakin ingin menghapus?",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                firestoreService.deleteGizi(docID);
                Navigator.pop(context);
              },
              child: const Text("Ya"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tidak"),
            ),
          ],
        );
      },
    );
  }

  // buat waktu mulai hari dan akhir hari
  DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999, 999);
  }

  DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  void errorMessage() {
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

  void parseCek() {
    // Parse date strings from controllers to DateTime objects
    DateTime? parsedDateAwal =
        DateTime.tryParse(dateAwalController.text);
    DateTime? parsedDateAkhir =
        DateTime.tryParse(dateAkhirController.text);

    if (historiOnly == true) {
      // Update dateAwal dan dateAkhir
      setState(() {
        dateAwal = parsedDateAwal;
        dateAkhir = parsedDateAkhir;
        historiOnly = false;
      });

      return;
    }
    // Check if parsing successful
    if (parsedDateAwal != null && parsedDateAkhir != null && !parsedDateAwal.isAfter(parsedDateAkhir)) {
      // Update dateAwal dan dateAkhir
      setState(() {
        dateAwal = parsedDateAwal;
        dateAkhir = parsedDateAkhir;
      });

      // firestoreService.getGiziStreamWithFilter(dateAwal, dateAkhir);
    } else {
      errorMessage();
    }
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
          'HISTORI STATUS GIZI\nGeMileActive', 
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
          DatePicker(
            text: 'Tanggal awal',
            dateController: dateAwalController,
            labelColor: Colors.white,
          ),
          const SizedBox(height: 5),
          DatePicker(
            text: 'Tanggal akhir',
            dateController: dateAkhirController,
            labelColor: Colors.white,
          ),
          const SizedBox(height: 20),
          MyButton(
            onTap: () {
              // cek data
              parseCek();
            },
            text: 'Cari',
            size: 25,
          ),
          const SizedBox(height: 20),
          MyButton(
            onTap: () { 
              historiOnly = true;
              
              parseCek();
              
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HistoriGiziPage(
                          dateAwal: dateAwal,
                          dateAkhir: dateAkhir,
                        )));
            },
            text: 'Lihat detail histori',
            size: 10,
          ),
          const SizedBox(height: 20),
          // ngambil data buat grafik
          if (dateAwal != null && dateAkhir != null)
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(
                      'status gizi_${FirebaseAuth.instance.currentUser!.uid}')
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
                  final imtValues = snapshot.data!.docs
                      .map<double>((doc) => doc['IMT'] as double)
                      .toList()
                      .take(5)
                      .toList();
                  final dates = snapshot.data!.docs
                      .map<Timestamp>((doc) => doc['timestamp'] as Timestamp)
                      .toList()
                      .take(5)
                      .toList();
                  final kategori = snapshot.data!.docs
                      .map<String>((doc) => doc['Kategori'] as String)
                      .toList()
                      .take(5)
                      .toList();
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text.rich(
                                TextSpan(
                                  style: TextStyle(color: Colors.white),
                                  children: <TextSpan>[
                                  TextSpan(text: 'Nilai IMT terakhir anda adalah ${imtValues[0].toStringAsFixed(1)}, ' 
                                  'Anda termasuk dalam kategori '),
                                  
                                  TextSpan(text: kategori[0], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,))
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
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: IMTLineChart(imtValues, dates),
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
              child: const Icon(
                Icons.add,
              ),
              backgroundColor: Colors.white,
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FormStatusGizi())),
            ),
    );
  }
}
