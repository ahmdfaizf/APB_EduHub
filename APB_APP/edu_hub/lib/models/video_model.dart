class VideoModel {
  final String judul;
  final String deskripsi;
  final String vidUrl;

  VideoModel({
    required this.judul,
    required this.deskripsi,
    required this.vidUrl,
  });

  Map<String, dynamic> toJson() => {
    'judul': judul,
    'deskripsi': deskripsi,
    'vidUrl': vidUrl,
  };

  static VideoModel fromJson(Map<String, dynamic> json) => VideoModel(
    judul: json['judul'],
    deskripsi: json['deskripsi'],
    vidUrl: json['vidUrl'],
  );
}
