import 'package:flutter/material.dart';

import '../components/date_picker.dart';
import '../components/my_button.dart';
import '../components/my_dropdown.dart';
import '../components/time_picker.dart';
import '../models/aktifitas.dart';
import '../services/firestore.dart';

class FormAktifitasPage extends StatefulWidget {
  FormAktifitasPage({super.key});

  @override
  State<FormAktifitasPage> createState() => _FormAktifitasPageState();
}

class _FormAktifitasPageState extends State<FormAktifitasPage> {
  // firestore
  final FirestoreService firestoreService = FirestoreService();

  // text editing controllers
  String tingkatAktifitasController = 'Tidak ada';

  String jenisAktifitasController = 'Tidak ada';

  final dateController = TextEditingController();

  final timeAwalController = TextEditingController();

  final timeAkhirController = TextEditingController();

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

  String tA = 'Tidak ada';

  String jA = 'Tidak ada';

  int calculateDurationInMinutes(TimeOfDay startTime, TimeOfDay endTime) {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;
    return endMinutes - startMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Cek Hasil Aktifitas Fisik'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("Aktifitas Fisik Baru", 
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
            
                const SizedBox(height: 20),
            
                // Tingkat Aktifitas
                DropdownField(
                  selectedItem: tingkatAktifitasController,
                  hintText: 'Tingkat Aktifitas',
                  listString: ['Tidak ada aktifitas', 'Aktifitas sedang', 'Aktifitas berat'],
                  onChange: (newValue) {
                    setState(() {
                      tingkatAktifitasController = newValue!;
                      jenisAktifitasController = 'Tidak ada';
                    });
                  },
                ),
            
                const SizedBox(height: 10),
            
                // Jenis Aktifitas
                if (tingkatAktifitasController == 'Aktifitas sedang')
                  DropdownField(
                    selectedItem: jenisAktifitasController,
                    hintText: 'Jenis Aktifitas',
                    listString: listAktifitasSedang,
                    onChange: (newValue) {
                      setState(() {
                        jenisAktifitasController = newValue!;
                      });
                    },
                  )
                else if (tingkatAktifitasController == 'Aktifitas berat')
                  DropdownField(
                    selectedItem: jenisAktifitasController,
                    hintText: 'Jenis Aktifitas',
                    listString: listAktifitasBerat,
                    onChange: (newValue) {
                      setState(() {
                        jenisAktifitasController = newValue!;
                      });
                    },
                  )
                else 
                  DropdownField(
                    selectedItem: jenisAktifitasController,
                    hintText: 'Jenis Aktifitas',
                    listString: ['Tidak ada'],
                    onChange: (newValue) {
                      setState(() {
                        jenisAktifitasController = newValue!;
                      });
                    },
                  ),
            
                const SizedBox(height: 10),

                // tanggal
                DatePicker(
                  text: 'Tanggal',
                  dateController: dateController,
                ),

                const SizedBox(height: 5),

                // waktu mulai dan berhenti
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TimePicker(
                        text: 'waktu mulai',
                        TimeController: timeAwalController
                      ),
                    ),
                    
                    Expanded(
                      child: TimePicker(
                        text: 'waktu selesai', 
                        TimeController: timeAkhirController),
                    )
                  ],
                ),

                const SizedBox(height: 10),
            
                // submit button
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

                    Aktifitas aktifitas = Aktifitas(
                      tingkatAktifitas: tA,
                      jenisAktifitas: jA,
                      duration: durationInMinutes,
                    );

                    print(aktifitas);
                    // add to db
                    // firestoreService.addBlock(aktifitas);

                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) => SummaryAktifitas()));
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