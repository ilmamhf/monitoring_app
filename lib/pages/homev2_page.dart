import 'package:flutter/material.dart';

import '../components/tombol_menu.dart';
import '../services/firebase_auth.dart';
import 'aktifitas_page.dart';
import 'form_aktifitas_page.dart';
import 'form_status_gizi.dart';
import 'profile_page.dart';
import 'status_list_page.dart';

class HomePageV2 extends StatefulWidget {
  const HomePageV2({super.key});

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    // final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
            width: double.infinity,
            color: Colors.blue[900],
            child: Center(
              child: Text(
                'MEMBER AREA\nGeMileActive', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (size.height/12) / 3 - 3,
                  color: Colors.white
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        toolbarHeight: size.height/12,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        
        children: [
          // cek status gizi
          MenuButton(
            teks: 'CEK STATUS GIZI',
            image: 'images/cek status gizi.jpeg',
            onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FormStatusGizi())),
          ),
          
          // cek aktifitas fisik
          MenuButton(
            teks: 'CEK AKTIFITAS FISIK',
            image: 'images/cek aktifitas fisik.jpeg',
            onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FormAktifitasPage())),
          ),
      
          // histori gizi
          MenuButton(
            teks: 'HISTORI STATUS GIZI',
            image: 'images/histori status gizi.jpeg',
            onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StatusPage())),
          ),
      
          // histori fisik
          MenuButton(
            teks: 'HISTORI AKTIFITAS FISIK',
            image: 'images/histori aktifitas fisik.jpeg',
            onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AktifitasFisikPage())),
          ),
      
          // grafik gizi
          MenuButton(
            teks: 'GRAFIK STATUS GIZI',
            image: 'images/grafik.jpeg',
            onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StatusPage()))
          ),
      
          // grafik fisik
          MenuButton(
            teks: 'GRAFIK AKTIFITAS FISIK',
            image: 'images/grafik.jpeg',
            onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AktifitasFisikPage()))
          ),
      
          // info
          MenuButton(
            teks: 'INFORMASI',
            image: 'images/akun.jpeg',
            onTap: () => {},
          ),
      
          // akun
          MenuButton(
            teks: 'AKUN',
            image: 'images/akun.jpeg',
            onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()))
          ),
        ]
      )
        

        // /// Status page
        // loginCheck() ? StatusPage() : _buildNotLoggedInPage(), // Tampilkan StatusPage hanya jika pengguna sudah login

        // /// Aktifitas page
        // loginCheck() ? AktifitasFisikPage() : _buildNotLoggedInPage(), // Tampilkan StatusPage hanya jika pengguna sudah login

        // /// Profile page
        // loginCheck() ? ProfilePage() : _buildNotLoggedInPage(), // Tampilkan StatusPage hanya jika pengguna sudah login

    );
  }
  
  Widget _buildNotLoggedInPage() {
    return Container(
      color: Colors.grey[300], // Set warna latar belakang menjadi abu-abu
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Silahkan Login Terlebih Dahulu"),

            TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/loginpage");
              },
              child: const Text(
                "Login", 
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }

}
