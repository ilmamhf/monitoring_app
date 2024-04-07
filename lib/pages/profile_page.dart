import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_or_register_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoggedIn = false;

  user() {
    if (FirebaseAuth.instance.currentUser != null) {
      isLoggedIn = true;
      return FirebaseAuth.instance.currentUser!.email;
    } else {
      return "User not logged in";
    }
  }

  Widget _login(isLoggedIn) {
    if (isLoggedIn) {
      return IconButton(
          onPressed: signUserOut, 
          icon: Icon(Icons.logout)
          );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, "/loginpage");
        },
        child: Text(
          "Login    ", 
          style: TextStyle(color: Colors.blue),
        ),
      );
    }
  }

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          _login(isLoggedIn)
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