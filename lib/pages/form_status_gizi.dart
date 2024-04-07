import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../models/status_gizi.dart';
import '../services/firestore.dart';

class FormStatusGizi extends StatelessWidget {
  FormStatusGizi({super.key});

  // firestore
  final FirestoreService firestoreService = FirestoreService();

  // text editing controllers
  final beratBadanController = TextEditingController();
  final tinggiBadanController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Cek Status Gizi'),
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
                  child: Text("Status Gizi Baru", 
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
            
                const SizedBox(height: 20),
            
                // Berat Badan
                MyTextField(
                  controller: beratBadanController,
                  hintText: 'Berat Badan dalam kg',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),
            
                // Tinggi Badan
                MyTextField(
                  controller: tinggiBadanController,
                  hintText: 'Tinggi Badan dalam cm',
                  obscureText: false,
                ),
            
                const SizedBox(height: 20),
            
                // submit button
                MyButton(
                  text: "Submit",
                  onTap: () {
                    bb = double.parse(beratBadanController.text);
                    tb = double.parse(tinggiBadanController.text);
                    IMT = bb / ((tb / 100) * (tb / 100));

                    StatusGizi gizi = StatusGizi(
                      beratBadan: bb,
                      tinggiBadan: tb,
                      IMT: IMT,
                      kategoriIMT: KategoriIMTCheck(IMT),
                    );
                    // add to db
                    firestoreService.addBlock(gizi);

                    // back
                    Navigator.pop(context);
                  },
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}