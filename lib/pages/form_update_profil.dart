import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/date_picker.dart';
import '../components/my_button.dart';
import '../components/my_dropdown.dart';
import '../components/my_textfield.dart';
import '../components/phone_field.dart';
import '../models/profil.dart';
import '../services/firestore.dart';

class FormUpdateProfil extends StatefulWidget {
  FormUpdateProfil({super.key});

  @override
  State<FormUpdateProfil> createState() => _FormUpdateProfilState();
}

class _FormUpdateProfilState extends State<FormUpdateProfil> {
  // firestore
  final FirestoreService firestoreService = FirestoreService();

  // text editing controllers
  final namaLengkapController = TextEditingController();
  final tglLahirController = TextEditingController();
  String kelaminController = '';
  final noHPController = TextEditingController();

  // error message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            message, 
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }


  // void submitStatusGizi() {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Cek Status Gizi'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("Profil Akun", 
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
            
                const SizedBox(height: 20),
            
                // Nama lengkap
                MyTextField(
                  controller: namaLengkapController,
                  hintText: 'Nama Lengkap',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),

                // tanggal lahir
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: DatePicker(
                    dateController: tglLahirController,
                    text: 'Tanggal Lahir',
                    labelColor: Colors.white,
                    ),
                ),
            
                const SizedBox(height: 10),

                // jenis kelamin
                DropdownField(
                  hintText: 'Jenis Kelamin',
                  listString: const [
                    'Pria',
                    'Wanita',
                  ],
                  selectedItem: kelaminController,
                  onChange: (newValue) {
                    setState(() {
                      kelaminController = newValue!;
                    });
                  },
                ),
            
                const SizedBox(height: 10),

                // no hp
                PhoneField(
                  phoneController: noHPController,
                ),
            
                const SizedBox(height: 20),
            
                // submit button
                MyButton(
                  text: "Perbarui Profil",
                  onTap: () {
                    if (namaLengkapController.text.isEmpty ||
                      tglLahirController.text.isEmpty ||
                      kelaminController.isEmpty ||
                      noHPController.text.isEmpty) {
                      showErrorMessage("Tidak boleh ada yang kosong");
                    } else {
                      // Ambil tanggal dari dateController
                      final tglLahir = DateTime.parse(tglLahirController.text);
                      // Buat objek Timestamp dari combinedDateTime
                      final timestamp = Timestamp.fromDate(tglLahir);

                      Profil userProfile = Profil(
                        nama: namaLengkapController.text,
                        tglLahir: timestamp,
                        jenisKelamin: kelaminController,
                        noHP: noHPController.text,
                      );

                      // add to db
                      FirestoreService().updateUser(userProfile);

                      // back
                      Navigator.pop(context);

                      showErrorMessage("Profil berhasil diperbarui");
                    }
                  },
                  size: 25,
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}