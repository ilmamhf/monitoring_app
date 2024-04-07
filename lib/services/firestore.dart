import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // get collection of blocks
  final CollectionReference blocks =
    FirebaseFirestore.instance.collection('blocks');

  // CREATE: add new block
  Future<void> addStatusGizi(block) {
    return blocks.add({
      'Berat Badan': block.beratBadan,
      'Tinggi Badan': block.tinggiBadan,
      'IMT': block.IMT,
      'Kategori': block.kategoriIMT,
      });
  }

  // READ: get blocks from database

  // UPDATE: update blocks given a doc id

  // DELETE: delete blocks given a doc id

}