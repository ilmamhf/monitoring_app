import 'package:flutter/material.dart';

import 'pages/auth_page.dart';
import 'pages/email_verification_page.dart';
import 'pages/home_page.dart';
import 'pages/homev2_page.dart';
import 'pages/login_or_register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar',
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      routes: {
        "/homepage": (_) => HomePageV2(),
        "/loginpage": (_) => LoginOrRegisterPage(),
        "/verifypage": (_) => VerifyEmailPage(),
      },
    );
  }
}