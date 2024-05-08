import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/date_picker.dart';
import '../components/my_button.dart';
import '../components/my_dropdown.dart';
import '../components/my_textfield.dart';

import '../components/skip_button.dart';
import '../models/profil.dart';
import '../services/firestore.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final namaLengkapController = TextEditingController();
  final tglLahirController = TextEditingController();
  String kelaminController = '';
  final noHPController = TextEditingController();

  // sign user up method
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );

    // check if password is confirmed
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      showErrorMessage("Passwords don't match!");
      return;
    }
    else {
      // try creating user
      try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text,
          );

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

          FirestoreService().addUser(userProfile);
          
          // pop the loading circle
          Navigator.pop(context);

          Navigator.pushReplacementNamed(context, '/homepage');

      } on FirebaseAuthException catch (e) {
          // pop the loading circle
          Navigator.pop(context);

          // show error message
          if (e.code == 'invalid-email') {
            showErrorMessage('Email is invalid');
          } else if (e.code == 'email-already-in-use') {
            showErrorMessage('The account already exists for that email.');
          }
      }
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          SkipButton()
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("Register", 
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
            
                const SizedBox(height: 20),
            
                // email
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),
            
                // password
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
            
                const SizedBox(height: 10),
            
                // confirm password
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Konfirmasi Password',
                  obscureText: true,
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
                MyTextField(
                  controller: noHPController,
                  hintText: 'No HP',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),
            
                // sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                  size: 25,
                ),
            
                // const SizedBox(height: 30),
            
                // // or continue with
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[600],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //         child: Text(
                //           'Or continue with',
                //           style: TextStyle(color: Colors.grey[600]),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[600],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
            
                // const SizedBox(height: 20),
            
                // // google sign in button
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     // google button
                //     Container(
                //       padding: const EdgeInsets.all(5),
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Colors.grey),
                //         borderRadius: BorderRadius.circular(8.0),
                //         color: Colors.white,
                //         ),
                //       child: Image.asset(
                //         'assets/images/google.png',
                //         height: 40,
                //       ),
                //     )
                //   ],
                // ),
            
                const SizedBox(height: 20,),
            
                // login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sudah punya akun?"),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login sekarang",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}