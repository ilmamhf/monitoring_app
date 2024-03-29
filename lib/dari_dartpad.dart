import 'package:flutter/material.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  void _print() {
    print("tes");
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.monitor_weight)),
            label: 'Status Gizi',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.directions_run),
            ),
            label: 'Aktifitas Fisik',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_2),
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Scaffold(
          appBar: AppBar(title: Text('Beranda'),),
          body: Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox.expand(
                  child: Center(
                    child: Text(
                      'Home page',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// Status page
        Scaffold(
          appBar: AppBar(title: Text('Status Gizi'),),
          body: Center(
            child: Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: Icon(Icons.monitor_weight),
                    title: Text('Status 2'),
                    subtitle: Text('statistik'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.monitor_weight),
                    title: Text('Status 1'),
                    subtitle: Text('statistik'),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _print,
            child: Icon(Icons.add),
          ),
        ),

        /// Aktifitas page
        Scaffold(
          appBar: AppBar(title: Text('Aktifitas Fisik'),),
          body: Center(
            child: Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: Icon(Icons.directions_run),
                    title: Text('Aktifitas 2'),
                    subtitle: Text('Isi aktifitas'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.directions_run),
                    title: Text('Aktifitas 1'),
                    subtitle: Text('Isi aktifitas'),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _print,
            child: Icon(Icons.add),
          ),
        ),

        /// Profile page
        Scaffold(
          appBar: AppBar(title: Text('Profil'),),
          body: ListView(
            children: [
              const SizedBox(height: 50,),
          
              // profile picture
              const Icon(
                Icons.person,
                size: 72,
              ),
          
              // username
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(left: 15, bottom: 15),
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // judul
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Username", style: TextStyle(color: Colors.grey[500]),),
          
                        IconButton(onPressed: (){}, icon: Icon(Icons.settings))
                      ],
                    ),
          
                    // isi
                    Text("Yanto"),
                  ],
                ),
              ),
          
              // email
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(left: 15, bottom: 15),
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // judul
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Email", style: TextStyle(color: Colors.grey[500]),),
          
                        IconButton(onPressed: (){}, icon: Icon(Icons.settings))
                      ],
                    ),
          
                    // isi
                    Text("Yanto@email.com"),
                  ],
                ),
              ),
          
              
            ],
          ),
        )
      ][currentPageIndex],
    );
  }
}
