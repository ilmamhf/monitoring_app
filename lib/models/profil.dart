import 'package:cloud_firestore/cloud_firestore.dart';

class Profil {
  final String nama;
  final Timestamp tglLahir;
  final String jenisKelamin;
  final String noHP;

  Profil({
    required this.nama,
    required this.tglLahir,
    required this.jenisKelamin,
    required this.noHP,
  });
}