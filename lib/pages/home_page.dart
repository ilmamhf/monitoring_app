import 'package:flutter/material.dart';

import 'aktifitas_page.dart';
import 'profile_page.dart';
import 'status_page.dart';

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
            icon: Icon(Icons.home),
            label: 'Home',
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
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Scaffold(
          appBar: AppBar(title: const Text('Beranda'),),
          body: Center(
            child: Column(
              children: [
                
                // informasi status gizi
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey,
                  ),
                  margin: const EdgeInsets.all(10),
                  height: 150,
                  child: const Center(
                    child: const Text("Status Gizi"),
                  ),
                ),
                
                // informasi aktifitas fisik
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey,
                  ),
                  margin: const EdgeInsets.all(10),
                  height: 150,
                  child: const Center(
                    child: Text("Aktifitas FIsik"),
                  )
                ),
              ],
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
