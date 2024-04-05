import 'package:flutter/material.dart';
import 'package:flutter_projek_app/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // logo
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text("Login", 
                  style: TextStyle(
                    fontSize: 60,
                  ),
                ),
              ),

              const SizedBox(height: 20),
          
              // username
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
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
          
              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              )
          
              // sign in button
          
              // google sign in button
          
              // register
            ],
          ),
        ),
      ),
    );
  }
}