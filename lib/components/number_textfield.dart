import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Color labelColor;

  const NumberField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.labelColor,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText, 
            textAlign: TextAlign.left,
            style: TextStyle(color: labelColor),
          ),

          SizedBox(height: 5,),

          TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              // Allow Decimal Number With Precision of 2 Only
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              // hintText: hintText,
              // hintStyle: TextStyle(color: Colors.grey[400]),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}