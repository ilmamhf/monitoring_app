import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.only(left: 15, bottom: 15),
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // judul
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Username", style: TextStyle(color: Colors.grey[500]),),
      
                    IconButton(onPressed: (){}, icon: const Icon(Icons.settings))
                  ],
                ),
      
                // isi
                const Text("Yanto"),
              ],
            ),
          ),
      
          // email
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.only(left: 15, bottom: 15),
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // judul
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Email", style: TextStyle(color: Colors.grey[500]),),
      
                    IconButton(onPressed: (){}, icon: const Icon(Icons.settings))
                  ],
                ),
      
                // isi
                Text(user()),
              ],
            ),
          ),
      
          
        ],
      ),
    );
  }
}