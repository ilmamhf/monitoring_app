import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  // get collection of blocks
  final CollectionReference blocks =
    FirebaseFirestore.instance.collection('status gizi_${FirebaseAuth.instance.currentUser!.uid}');

  final CollectionReference blokAktifitas =
    FirebaseFirestore.instance.collection('aktifitas fisik_${FirebaseAuth.instance.currentUser!.uid}');

  // CREATE: add new block
  Future<void> addGizi(gizi) {
    return blocks.add({
      'Berat Badan': gizi.beratBadan,
      'Tinggi Badan': gizi.tinggiBadan,
      'IMT': gizi.IMT,
      'Kategori': gizi.kategoriIMT,
      'timestamp' : Timestamp.now(),
      });
  }

  Future<void> addAktifitas(aktifitas) {
    return blokAktifitas.add({
      'Tingkat Aktifitas': aktifitas.tingkatAktifitas,
      'Jenis Aktifitas': aktifitas.jenisAktifitas,
      'Durasi': aktifitas.duration,
      'Poin': aktifitas.poin,
      'timestamp': aktifitas.timestamp,
      });
  }

  // // READ: get blocks from database
  // Stream<QuerySnapshot> getGiziStream() {
  //   final giziStream =
  //     blocks.orderBy('timestamp', descending: true).snapshots();

  //   return giziStream;
  // }

  // // query date filter
  // Query<Object?> getGiziStreamWithFilter(dateAwal, dateAkhir) {
  //   final giziQuery =
  //     blocks.where(Filter.and(
  //       Filter('timestamp', isGreaterThanOrEqualTo: dateAwal), 
  //       Filter('timestamp', isLessThanOrEqualTo: Timestamp.fromDate(dateAkhir!)),
  //       )
  //     );

  //   return giziQuery;
  // }

  

  // UPDATE: update blocks given a doc id
  // Future<void> updateGizi(String docID, String newGizi) {
  //   return blocks.doc(docID).update(
  //     ''
  //   )
  // }

  // DELETE: delete blocks given a doc id
  Future<void> deleteGizi(String docID) {
    return blocks.doc(docID).delete();
  }

  Future<void> deleteAktifitas(String docID) {
    return blokAktifitas.doc(docID).delete();
  }

}