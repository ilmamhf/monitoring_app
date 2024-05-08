import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firebase_auth.dart';
import '../services/firestore.dart';
import 'form_aktifitas_page.dart';

class Histori2AktifitasPage extends StatefulWidget {
  final DateTime? dateAwal;
  final DateTime? dateAkhir;
  
  const Histori2AktifitasPage({
    super.key, 
    required this.dateAwal, 
    required this.dateAkhir
  });

  @override
  State<Histori2AktifitasPage> createState() => _Histori2AktifitasPageState();
}

class _Histori2AktifitasPageState extends State<Histori2AktifitasPage> {
  
  // firestore
  final FirestoreService firestoreService = FirestoreService();

  // delete message popup
  void showDeleteMessage(docID) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Apakah kamu yakin ingin menghapus?", 
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                firestoreService.deleteAktifitas(docID);
                Navigator.pop(context);
                }, 
              child: Text("Ya")),
            
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text("Tidak")),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aktifitas Fisik'),),
      body: SafeArea(
        child: Column(
          children: [
            
            // list aktifitas
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
              .collection('aktifitas fisik_${FirebaseAuth.instance.currentUser!.uid}') // Ganti dengan nama koleksi Firestore Anda
              .where('timestamp', isGreaterThanOrEqualTo: widget.dateAwal != null ? Timestamp.fromDate(startOfDay(widget.dateAwal!)) : null)
              .where('timestamp', isLessThanOrEqualTo: widget.dateAkhir != null ? Timestamp.fromDate(endOfDay(widget.dateAkhir!)) : null)
              .orderBy('timestamp', descending: true)
              .snapshots(),
              builder: (context, snapshot) {
                // login check
                if (loginCheck()) {
                  // if we have data, get all docs
                  if (snapshot.hasData) {
                    List aktifitasList = snapshot.data!.docs;
            
                    if (aktifitasList.isEmpty) {
                      return const Center(child: Text("Histori kosong"));
                    } else {
                    // display as a list
                    return Expanded(
                      child: ListView.builder(
                        itemCount: aktifitasList.length,
                        itemBuilder: (context, index) {
                          // get individual doc
                          DocumentSnapshot document = aktifitasList[index];
                          String docID = document.id;
                                
                          // get data from each doc
                          Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
        
                          // Handle null timestamp
                          Timestamp aktifitasTime;
                          if(data.containsKey('timestamp') && data['timestamp'] != null) {
                            aktifitasTime = data['timestamp'] as Timestamp;
                          } else {
                            // Lakukan penanganan kesalahan atau atur nilai default jika field 'timestamp' null
                            aktifitasTime = Timestamp.now(); // Contoh: Menggunakan timestamp saat ini sebagai nilai default
                          }
                          
                          String tingkatAktifitas = data['Tingkat Aktifitas'];
                          String jenisAktifitas = data['Jenis Aktifitas'];
                          int durasi = data['Durasi'];
                          int poin = data['Poin'];
                                
                          // display as a list tile
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                ),
                              child: ListTile(
                                title: Text(
                                  "Tingkat Aktifitas : " + tingkatAktifitas +
                                  "\nJenis Aktifitas : " + jenisAktifitas +
                                  "\nDurasi : " + durasi.toString() + ' menit' +
                                  "\nNilai Aktifitas : " + poin.toString() + ' poin'
                                  ),
                                subtitle: Text(aktifitasTime.toDate().toLocal().toString().split(" ")[0], textAlign: TextAlign.right,),
                                trailing: Ink(
                                  child: IconButton.filled(
                                    onPressed: () => showDeleteMessage(docID),
                                    icon: const Icon(Icons.delete),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.blue[200],
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))),
                                  ),
                                )
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  }
            
                  // if there is no data return nothing
                  else {
                    return const Center(child: Text("Loading.."));
                  }
            
                } else {
                return const Center(child: Text("Silahkan Login terlebih dahulu"));
                }
              },
            ),
          ],
        ),
      ),

      floatingActionButton: !loginCheck() 
        ? Container()
        : FloatingActionButton(
          child: const Icon(
            Icons.add,
          ),
          backgroundColor: Colors.white,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FormAktifitasPage()))
      ),
    );
  }
}
