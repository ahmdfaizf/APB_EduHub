import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  final String judul;
  final double nilai;
  final int attempt;
  final String courseId;

  QuizModel({
    required this.judul,
    required this.nilai,
    required this.attempt,
    required this.courseId,
  });

  // Metode untuk mengubah objek menjadi map
  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'nilai': nilai,
      'attempt': attempt,
      'courseId': courseId,
      'timestamp': FieldValue.serverTimestamp(), // Tambahkan timestamp
    };
  }

  // Metode untuk membuat objek dari map
  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      judul: json['judul'],
      nilai: json['nilai'],
      attempt: json['attempt'],
      courseId: json['courseId'],
    );
  }
}
