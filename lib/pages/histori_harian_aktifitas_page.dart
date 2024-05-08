import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/aktifitas.dart';

class DailyActivity {
  final DateTime date;
  final List<Aktifitas> aktifitasList;

  DailyActivity({
    required this.date,
    required this.aktifitasList,
  });
}

class AktifitasHarianPage extends StatefulWidget {
  final DateTime dateAwal;
  final DateTime dateAkhir;

  const AktifitasHarianPage({
    Key? key,
    required this.dateAwal,
    required this.dateAkhir,
  }) : super(key: key);

  @override
  State<AktifitasHarianPage> createState() => _AktifitasHarianPageState();
}

class _AktifitasHarianPageState extends State<AktifitasHarianPage> {
  late List<DailyActivity> dailyActivities;

  @override
  void initState() {
    super.initState();
    fetchDailyActivities();
  }

  Future<void> fetchDailyActivities() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final snapshots = await FirebaseFirestore.instance
          .collection('aktifitas fisik_$userId')
          .where('timestamp', isGreaterThanOrEqualTo: widget.dateAwal)
          .where('timestamp', isLessThanOrEqualTo: widget.dateAkhir)
          .orderBy('timestamp')
          .get();

      final dailyActivityMap = <DateTime, List<Aktifitas>>{};

      for (final doc in snapshots.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final timestamp = data['timestamp'] as Timestamp;
        final date = timestamp.toDate().toLocal();
        final aktifitas = Aktifitas(
          tingkatAktifitas: data['Tingkat Aktifitas'] ?? '',
          jenisAktifitas: data['Jenis Aktifitas'] ?? '',
          duration: data['Durasi'] ?? 0,
          poin: data['Poin'] ?? 0,
          timestamp: Timestamp.fromDate(date),
        );

        if (dailyActivityMap.containsKey(date)) {
          dailyActivityMap[date]!.add(aktifitas);
        } else {
          dailyActivityMap[date] = [aktifitas];
        }
      }

      final sortedDates =
          dailyActivityMap.keys.toList()..sort((a, b) => b.compareTo(a));
      dailyActivities = sortedDates
          .map((date) => DailyActivity(
                date: date,
                aktifitasList: dailyActivityMap[date]!,
              ))
          .toList();

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aktivitas Fisik')),
      body: SafeArea(
        child: Column(
          children: [
            if (dailyActivities.isEmpty)
              const Center(
                  child: Text(
                      "Tidak ada aktivitas fisik dalam rentang waktu yang dipilih")),
            Expanded(
              child: ListView.builder(
                itemCount: dailyActivities.length,
                itemBuilder: (context, index) {
                  final dailyActivity = dailyActivities[index];
                  return _buildDailyActivityCard(dailyActivity);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyActivityCard(DailyActivity dailyActivity) {
    final aktifitasBerat = dailyActivity.aktifitasList
        .where((aktifitas) => aktifitas.tingkatAktifitas == 'Aktifitas Berat')
        .toList();
    final aktifitasSedang = dailyActivity.aktifitasList
        .where((aktifitas) => aktifitas.tingkatAktifitas == 'Aktifitas Sedang')
        .toList();
    final durasiBerat =
        aktifitasBerat.fold<int>(0, (sum, aktifitas) => sum + aktifitas.duration);
    final durasiSedang =
        aktifitasSedang.fold<int>(0, (sum, aktifitas) => sum + aktifitas.duration);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tanggal ${dailyActivity.date.day}/${dailyActivity.date.month}/${dailyActivity.date.year}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Aktivitas Berat: ${durasiBerat} menit'),
              Text('Aktivitas Sedang: ${durasiSedang} menit'),
            ],
          ),
        ),
      ),
    );
  }
}
