import 'package:flutter/material.dart';

class TextDisplay extends StatelessWidget {
  final String text;
  final String judul;

  const TextDisplay({
    super.key, 
    required this.text,
    required this.judul,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15, top: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // judul
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(judul, style: TextStyle(color: Colors.grey[500]),),
  
              // IconButton(onPressed: (){}, icon: const Icon(Icons.settings))
            ],
          ),
  
          // isi
          Text(text),
        ],
      ),
    );
  }
}