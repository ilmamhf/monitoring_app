class StatusGizi {
  final double beratBadan;
  final double tinggiBadan;
  final double IMT;
  final String kategoriIMT;

  StatusGizi({
  required this.beratBadan,
  required this.tinggiBadan,
  required this.IMT,
  required this.kategoriIMT,
  });

  // factory StatusGizi.fromMap(Map<String, dynamic> map) {
  //   return StatusGizi(
  //     beratBadan: map['Berat Badan'],
  //     tinggiBadan: map['Tinggi Badan'],
  //     IMT: map['IMT'],
  //     kategoriIMT: map['Kategori'],
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'Berat Badan': beratBadan,
  //     'Tinggi Badan': tinggiBadan,
  //     'IMT': IMT,
  //     'Kategori': kategoriIMT,
  //   };
  // }
}

// // kategori IMT
// enum KategoriIMT {
//   sangatKurus,
//   kurus,
//   normal,
//   giziLebih,
//   obesitas,
// }
