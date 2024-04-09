import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage2 extends StatelessWidget {
  HomePage2({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut, 
            icon: const Icon(Icons.logout)
            )
          ]
        ),
      body: Center(child: Text("LOGGED IN AS: " + user.email!,
      ),),
    );
  }
}