import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class FormForgotPassword extends StatefulWidget {
  FormForgotPassword({super.key});

  @override
  State<FormForgotPassword> createState() => _FormForgotPasswordState();
}

class _FormForgotPasswordState extends State<FormForgotPassword> {
  // text editing controllers
  final emailController = TextEditingController();

  // message popup
  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            message, 
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              }, 
              child: Text("Ok")
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showMessage("Link reset password sudah kami kirimkan ke email anda!");
    } on FirebaseAuthException catch (e) {
      showMessage(e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // teks
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Masukkan email anda dan kami akan mengirimkan link untuk mereset password anda", textAlign: TextAlign.center,),
            ),

            const SizedBox(height: 20),

            // textform
            MyTextField(
              controller: emailController, 
              hintText: 'Email', 
              obscureText: false,
            ),

            const SizedBox(height: 20),

            // tombol reset password
            MyButton(
              onTap: () {resetPassword();}, 
              text: 'Reset Password', 
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}