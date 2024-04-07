import 'package:flutter/material.dart';

import 'form_aktifitas_page.dart';

class AktifitasPage extends StatelessWidget {
  const AktifitasPage({super.key});

  void _print() {
    print("tes");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: const Text('Aktifitas Fisik'),),
          body: const Center(
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
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FormAktifitasPage())),
            child: const Icon(Icons.add),
          ),
        );
  }
}