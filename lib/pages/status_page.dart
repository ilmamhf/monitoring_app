import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firestore.dart';
import 'form_status_gizi.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  // firestore
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Gizi'),),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getGiziStream(),
        builder: (context, snapshot) {
          // if we have data, get all docs
          if (snapshot.hasData) {
            List giziList = snapshot.data!.docs;

            // display as a list
            return ListView.builder(
              itemCount: giziList.length,
              itemBuilder: (context, index) {
                // get individual doc
                DocumentSnapshot document = giziList[index];
                String docID = document.id;

                // get data from each doc
                Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
                Timestamp giziTime = data['timestamp'];
                double giziBerat = data['Berat Badan'];
                double giziTinggi = data['Tinggi Badan'];
                double giziIMT = data['IMT'];
                String giziKategori = data['Kategori'];

                // display as a list tile
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                      ),
                    child: ListTile(
                      title: Text(
                        "Berat Badan : " + giziBerat.toStringAsFixed(1) + " kg" +
                        "\nTinggi Badan : " + giziTinggi.toStringAsFixed(1) + " cm" +
                        "\nNilai IMT : " + giziIMT.toStringAsFixed(1) +
                        "\nKategori IMT : $giziKategori"
                        ),
                      subtitle: Text(giziTime.toDate().toLocal().toString(), textAlign: TextAlign.right,),
                    ),
                  ),
                );
              },
            );
          }

          // if there is no data return nothing
          else {
            return const Text("Histori kosong");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FormStatusGizi())),
        child: const Icon(Icons.add),
      ),
    );
  }
}