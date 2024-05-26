import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String teks;
  final String image;
  final Function()? onTap;
  
  const MenuButton({
    super.key,
    required this.teks,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    double box = size.width/2.5;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image(
                  image: AssetImage(image),
                ),
              )
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  // ui
                  child: Container(
                    width: double.infinity,
                    height: box/2.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 10), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        teks,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          
                        ),
                      )
                    ),
                  ),

                  // fungsi
                  onTap: onTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}