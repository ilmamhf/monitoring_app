import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  void _print() {
    print("tes");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Gizi'),),
      body: const Center(
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
        child: const Icon(Icons.add),
      ),
    );
  }
}