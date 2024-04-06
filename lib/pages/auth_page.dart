import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projek_app/pages/home_page.dart';
import 'package:flutter_projek_app/pages/home_page2.dart';
import 'package:flutter_projek_app/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if user is logged in
          if (snapshot.hasData) {
            return HomePage2();
          }

          // if user is NOT logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}