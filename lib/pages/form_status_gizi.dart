import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/date_picker.dart';
import '../components/my_button.dart';
import '../components/number_textfield.dart';
import '../models/status_gizi.dart';
import '../services/firestore.dart';
import 'summary_gizi_page.dart';

class FormStatusGizi extends StatelessWidget {
  FormStatusGizi({super.key});

  // firestore
  final FirestoreService firestoreService = FirestoreService();

  // text editing controllers
  final beratBadanController = TextEditingController();
  final tinggiBadanController = TextEditingController();
  final dateController = TextEditingController();

  double bb = 0;
  double tb = 0;
  double IMT = 0;

  KategoriIMTCheck(IMT) {
    print(IMT);
    if (IMT <= 17) {
      return "Sangat Kurus";
    } else if (IMT > 17 && IMT <= 18.49) {
      return "Kurus";
    } else if (IMT >= 18.5 && IMT <= 25) {
      return "Normal";
    } else if (IMT >= 25.01 && IMT <= 27){
      return "Gizi Lebih";
    } else if (IMT > 27) {
      return "Obesitas";
    }
  }

  // void submitStatusGizi() {
  //   if (beratBadanController.value != double) {
  //     showErrorMessage("Isi dengan angka!");
  //     return;
  //   }

  // }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Color.fromARGB(255, 9, 53, 147),
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 52, 79, 255),
        backgroundColor: Color.fromARGB(255, 9, 53, 147),
        title: Text(
          'CEK STATUS GIZI\nGeMileActive', 
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
                      image: AssetImage('images/cek status gizi.jpeg'),
                    ),
                  )
                ),
            
                const SizedBox(height: 20),
            
                // Berat Badan
                NumberField(
                  controller: beratBadanController,
                  hintText: 'Berat Badan (kg)',
                  obscureText: false,
                  labelColor: Colors.white,
                ),
            
                const SizedBox(height: 10),
            
                // Tinggi Badan
                NumberField(
                  controller: tinggiBadanController,
                  hintText: 'Tinggi Badan (cm)',
                  obscureText: false,
                  labelColor: Colors.white,
                ),

                const SizedBox(height: 10),

                // tanggal
                DatePicker(
                  text: 'Tanggal',
                  dateController: dateController,
                  labelColor: Colors.white,
                ),
            
                const SizedBox(height: 20),
            
                // submit button
                MyButton(
                  text: "Submit",
                  onTap: () {
                    bb = double.parse(beratBadanController.text);
                    tb = double.parse(tinggiBadanController.text);
                    IMT = bb / ((tb / 100) * (tb / 100));

                    // Ambil tanggal dari dateController
                    final selectedDate = DateTime.parse(dateController.text);

                    // Ambil waktu jam saat ini
                    final currentTime = DateTime.now();
                    
                    // Gabungkan tanggal dan waktu
                    final combinedDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      currentTime.hour,
                      currentTime.minute,
                      currentTime.second,
                    );

                    // Buat objek Timestamp dari combinedDateTime
                    final timestamp = Timestamp.fromDate(combinedDateTime);

                    StatusGizi gizi = StatusGizi(
                      beratBadan: bb,
                      tinggiBadan: tb,
                      IMT: IMT,
                      kategoriIMT: KategoriIMTCheck(IMT),
                      timestamp: timestamp,
                    );
                    
                    // add to db
                    firestoreService.addGizi(gizi);

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SummaryGizi(
                        beratBadan: bb, 
                        tinggiBadan: tb, 
                        IMT: IMT, 
                        kategoriIMT: gizi.kategoriIMT, )));

                    // // back
                    // Navigator.pop(context);
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