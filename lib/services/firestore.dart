import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  // get collection of blocks
  final CollectionReference blocks =
    FirebaseFirestore.instance.collection('status gizi_${FirebaseAuth.instance.currentUser!.uid}');

  // CREATE: add new block
  Future<void> addBlock(block) {
    return blocks.add({
      'Berat Badan': block.beratBadan,
      'Tinggi Badan': block.tinggiBadan,
      'IMT': block.IMT,
      'Kategori': block.kategoriIMT,
      'timestamp' : Timestamp.now(),
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

}