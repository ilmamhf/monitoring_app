import 'package:flutter/material.dart';

import 'aktifitas_page.dart';
import 'profile_page.dart';
import 'status_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  void _print() {
    print("tes");
  }

  @override
  Widget build(BuildContext context) {
    // final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.transparent,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.blue,),
            icon: Icon(Icons.home,),
            label: 'Beranda',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.monitor_weight, color: Colors.blue,),
            icon: Icon(Icons.monitor_weight),
            label: 'Status Gizi',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.directions_run, color: Colors.blue,),
            icon: Icon(Icons.directions_run),
            label: 'Aktifitas Fisik',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_2, color: Colors.blue,),
            icon: Icon(Icons.person_2),
            label: 'Profil',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Scaffold(
          appBar: AppBar(title: const Text('Beranda'),),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Status Gizi", style: TextStyle(fontSize: 20),),
                    Text(
                      """
                      \nStatus gizi merujuk pada kondisi nutrisi seseorang, yang mencakup asupan makanan dan penyerapan nutrisi dalam tubuh.
                      \nSalah satu alat yang umum digunakan untuk mengukur status gizi adalah Indeks Masa Tubuh (IMT), yang memperhitungkan berat badan dan tinggi badan seseorang.
                      \nBerdasarkan nilai IMT, seseorang dapat diklasifikasikan ke dalam kategori seperti sangat kurus, kurus, normal, gizi lebih, hingga obesitas.
                      """),
                    Text("\nAktivitas Fisik", style: TextStyle(fontSize: 20),),
                    Text(
                      """
                      \nAktivitas fisik merujuk pada segala gerakan tubuh yang menghabiskan energi, penting untuk menjaga kesehatan dan kebugaran tubuh.
                      \nPedoman kesehatan merekomendasikan setidaknya 150 menit aktivitas aerobik moderat atau 75 menit aktivitas aerobik intensitas tinggi setiap minggu, ditambah latihan kekuatan otot minimal dua kali seminggu.
                      \nJenis aktivitas fisik sangat bervariasi, mulai dari olahraga formal seperti berlari atau berenang, hingga aktivitas sehari-hari seperti berjalan kaki atau membersihkan rumah. Pilihan aktivitas sebaiknya disesuaikan dengan kondisi fisik dan preferensi individu, yang terpenting adalah memilih aktivitas yang dapat dipertahankan secara teratur dan memberikan manfaat bagi kesehatan tubuh secara keseluruhan.
                      """
                    ),
                  ],
                ),
              )
            ),
          )
        ),

        /// Status page
        StatusPage(),

        /// Aktifitas page
        AktifitasPage(),

        /// Profile page
        ProfilePage(),

      ][currentPageIndex],
    );
  }
}
