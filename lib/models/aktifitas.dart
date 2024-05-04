import 'package:cloud_firestore/cloud_firestore.dart';

class Aktifitas {
  final String tingkatAktifitas;
  final String jenisAktifitas;
  final int duration;
  final int poin;
  final Timestamp timestamp;

  Aktifitas({
    required this.tingkatAktifitas,
    required this.jenisAktifitas, 
    required this.duration,
    required this.poin,
    required this.timestamp
  });
}