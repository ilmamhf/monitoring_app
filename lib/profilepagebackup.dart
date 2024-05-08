import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/my_button.dart';
import '../components/text_display.dart';
import '../services/firebase_auth.dart';
import 'pages/form_update_profil.dart';

class ProfilePagezz extends StatefulWidget {
  const ProfilePagezz({super.key});

  @override
  State<ProfilePagezz> createState() => _ProfilePagezzState();
}

class _ProfilePagezzState extends State<ProfilePagezz> {

  String? namaLengkap;
  Timestamp? tglLahir;
  String? jenisKelamin;
  String? noHP;

  user() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.email;
    } else {
      return "User not logged in";
    }
  }

  Widget _login() {
    if (!loginCheck()) {
      return GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, "/loginpage");
        },
        child: const Text(
          "Login    ", 
          style: TextStyle(color: Colors.blue),
        ),
      );
    } else {
      return IconButton(
        onPressed: signUserOut, 
        icon: const Icon(Icons.logout)
        );
    }
  }

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, "/loginpage");
  }

  // ambil data profil
  Future<String> getProfil(String apa) async {
    if (!loginCheck()) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

      // Memeriksa apakah dokumen pengguna ditemukan
      if (userDoc.exists) {
        // Mendapatkan data dari dokumen pengguna
        final Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

        // Memastikan userData tidak null sebelum mengakses fieldnya
        if (userData != null) {
          // Mengakses masing-masing field dari dokumen pengguna
          namaLengkap = userData['Nama Lengkap'];
          tglLahir = userData['Tanggal Lahir'];
          jenisKelamin = userData['Jenis Kelamin'];
          noHP = userData['No HP'];

          return namaLengkap!;
          
        } else {
          return 'Data pengguna kosong';
        }
      } else {
        return 'Dokumen pengguna tidak ditemukan';
      }
      
    } else {
      return 'Belum login';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          _login()
          ]
        ),
      body: ListView(
        children: [
          const SizedBox(height: 50,),
      
          // profile picture
          const Icon(
            Icons.person,
            size: 72,
          ),
      
          // username
          TextDisplay(
            judul: 'Nama',
            text: '${getProfil('Nama')}',
          ),
      
          // email
          TextDisplay(
            judul: 'Email',
            text: user()
          ),

          // edit profil button
          MyButton(
            text: "Sign In",
            onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) => FormUpdateProfil())),
            size: 8,
          ),
      
          
        ],
      ),
    );
  }
}