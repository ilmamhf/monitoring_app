import 'package:cloud_firestore/cloud_firestore.dart';

class AktifitasV2 {
  final int aktifitasSedang;
  final int aktifitasBerat;
  final Timestamp timestamp;

  AktifitasV2({
    required this.aktifitasSedang,
    required this.aktifitasBerat,
    required this.timestamp
  });
}