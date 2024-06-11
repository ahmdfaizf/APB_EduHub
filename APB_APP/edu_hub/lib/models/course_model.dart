class CourseModel {
  final String judul;
  final String deskripsi;
  final String urlGambar;  // Tambahkan field untuk URL gambar

  CourseModel({
    required this.judul,
    required this.deskripsi,
    required this.urlGambar,  // Tambahkan field ini di konstruktor
  });

  Map<String, dynamic> toJson() => {
    'judul': judul,
    'deskripsi': deskripsi,
    'urlGambar': urlGambar,  // Tambahkan field ini di metode toJson
  };

  static CourseModel fromJson(Map<String, dynamic> json) => CourseModel(
    judul: json['judul'],
    deskripsi: json['deskripsi'],
    urlGambar: json['urlGambar'],  // Tambahkan field ini di metode fromJson
  );
}
