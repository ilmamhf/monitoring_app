import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  SkipButton({super.key,});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, "/homepage");
      }, 
      icon: const Icon(Icons.arrow_right_alt),
    );
  }
}