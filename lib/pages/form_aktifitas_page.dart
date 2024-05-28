import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/date_picker.dart';
import '../components/my_button.dart';
import '../components/my_dropdown.dart';
import '../components/time_picker.dart';
import '../models/aktifitas.dart';
import '../services/firestore.dart';
import 'summary_aktifitas.dart';

class FormAktifitasPage extends StatefulWidget {
  FormAktifitasPage({Key? key}) : super(key: key);

  @override
  _FormAktifitasPageState createState() => _FormAktifitasPageState();
}

class _FormAktifitasPageState extends State<FormAktifitasPage> {
  final FirestoreService firestoreService = FirestoreService();

  final dateController = TextEditingController();
  final timeAwalController = TextEditingController();
  final timeAkhirController = TextEditingController();

  String tingkatAktifitasController = 'Tidak ada aktifitas';
  String jenisAktifitasController = '';
  List<String> listAktifitasSedang = [
    'Olahraga ringan',
    'Olahraga sedang',
    'Aktifitas rumah ringan',
    'Berkebun sedang'
  ];
  List<String> listAktifitasBerat = [
    'Olahraga berat',
    'Aktifitas rumah berat',
    'Berkebun berat',
    'Perbaikan rumah'
  ];
  DateTime? date;
  String? tA;
  String? jA;
  int poin = 0;

  int calculateDurationInMinutes(TimeOfDay startTime, TimeOfDay endTime) {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;
    return endMinutes - startMinutes;
  }

  void showErrorDialog(String teks) {
    // Show error message if parsing fails
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            teks, 
            textAlign: TextAlign.center,
            textScaler: TextScaler.linear(1),),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 9, 53, 147),
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 52, 79, 255),
        backgroundColor: Color.fromARGB(255, 9, 53, 147),
        title: Text(
          'HISTORI AKTIFITAS FISIK\nGeMileActive', 
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: (size.height/12) / 3 - 3,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    width: size.width/3,
                    height: size.width/3,
                    child: Image(
                      image: AssetImage('images/cek aktifitas fisik.jpeg'),
                    ),
                  )
                ),

                const SizedBox(height: 20),

                // tingkat aktifitas
                DropdownField(
                  hintText: 'Tingkat Aktifitas',
                  labelColor: Colors.white,
                  listString: [
                    'Tidak ada aktifitas',
                    'Aktifitas sedang',
                    'Aktifitas berat'
                  ],
                  selectedItem: tingkatAktifitasController,
                  onChange: (newValue) {
                    setState(() {
                      tingkatAktifitasController = newValue!;
                      jenisAktifitasController = ''; // Kosongkan jenis aktifitas
                    });
                  },
                ),

                const SizedBox(height: 5),
                
                // jenis aktifitas
                DropdownField(
                  labelColor: Colors.white,
                  hintText: 'Jenis Aktifitas',
                  listString: tingkatAktifitasController == 'Aktifitas sedang'
                      ? listAktifitasSedang
                      : tingkatAktifitasController == 'Aktifitas berat'
                          ? listAktifitasBerat
                          : ['Tidak ada'],
                  selectedItem: jenisAktifitasController,
                  onChange: (newValue) {
                    setState(() {
                      jenisAktifitasController = newValue!;
                    });
                  },
                ),

                const SizedBox(height: 5),
                
                // tanggal
                DatePicker(
                  text: 'Tanggal',
                  dateController: dateController,
                  labelColor: Colors.white,
                ),

                const SizedBox(height: 5),
                
                // waktu mulai dan selesai
                TimePicker(
                  text: 'waktu mulai',
                  TimeController: timeAwalController,
                  labelColor: Colors.white,
                ),

                const SizedBox(height: 5),

                TimePicker(
                  text: 'waktu selesai',
                  TimeController: timeAkhirController,
                  labelColor: Colors.white,
                ),

                const SizedBox(height: 20),

                MyButton(
                  text: "Submit",
                  onTap: () {
                    tA = tingkatAktifitasController;
                    jA = jenisAktifitasController;

                    final durationInMinutes = calculateDurationInMinutes(
                      TimeOfDay(
                        hour: int.parse(timeAwalController.text.split(':')[0]),
                        minute: int.parse(timeAwalController.text.split(':')[1]),
                      ),
                      TimeOfDay(
                        hour: int.parse(timeAkhirController.text.split(':')[0]),
                        minute: int.parse(timeAkhirController.text.split(':')[1]),
                      ),
                    );

                    // Ambil tanggal dari dateController
                    final selectedDate = DateTime.parse(dateController.text);
                    
                    // Ambil waktu selesai dari timeAkhirController
                    final endTime = TimeOfDay(
                      hour: int.parse(timeAkhirController.text.split(':')[0]),
                      minute: int.parse(timeAkhirController.text.split(':')[1]),
                    );

                    // Gabungkan tanggal dan waktu selesai menjadi satu objek DateTime
                    final combinedDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      endTime.hour,
                      endTime.minute,
                    );

                    // Buat objek Timestamp dari combinedDateTime
                    final timestamp = Timestamp.fromDate(combinedDateTime);

                    if (tA == 'Aktifitas sedang') {
                      poin = durationInMinutes * 4;
                    } else if (tA == 'Aktifitas berat') {
                      poin = durationInMinutes * 8;
                    }

                    // check apakah
                    if (durationInMinutes < 0) {
                      showErrorDialog('Format waktu tidak valid!');
                    } else if (tA != null && jA != null && tA != 'Tidak ada' && jA != 'Tidak ada') {
                      Aktifitas aktifitas = Aktifitas(
                        tingkatAktifitas: tA!,
                        jenisAktifitas: jA!,
                        duration: durationInMinutes,
                        poin: poin,
                        timestamp: timestamp
                      );

                      print(aktifitas.duration);
                      // add to db
                      firestoreService.addAktifitas(aktifitas);

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SummaryAktifitas(
                          tingkatAktifitas: tA!,
                          jenisAktifitas: jA!,
                          duration: durationInMinutes,
                          poin: poin,
                        )
                      )
                    );
                    } else {
                      showErrorDialog('Harus ada aktifitas!');
                    }
                  },
                  size: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}