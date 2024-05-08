import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/my_button.dart';
import '../components/text_display.dart';
import '../services/firebase_auth.dart';
import 'form_update_profil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  user() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.email;
    } else {
      return;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          _login()
          ]
        ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(currentUser.uid).snapshots(),
        builder: ((context, snapshot) {
          // get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            String nama = userData['Nama Lengkap'];

            return ListView(
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
                  text: nama,
                ),
            
                // email
                TextDisplay(
                  judul: 'Email',
                  text: user()
                ),

                const SizedBox(height: 20),

                // edit profil button
                MyButton(
                  text: "Ubah Profil",
                  onTap: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FormUpdateProfil())),
                  size: 8,
                ),
            
                
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }

          return const Center(child: CircularProgressIndicator(),);
        }
        ),
      )
    );
  }
}