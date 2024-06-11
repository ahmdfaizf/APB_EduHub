import 'package:edu_hub/page/course_detail_page.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final Map<String, dynamic> quizData;

  const QuizPage({super.key, required this.quizData});

  @override
  // ignore: library_private_types_in_public_api
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestion = 0;
  int _score = 0;

  // Data pertanyaan dan jawaban
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Contoh soal nomor 1',
      'options': ['Opsi A', 'Opsi B', 'Opsi C', 'Opsi D', 'Opsi E'],
      'answer': 2, // Indeks opsi jawaban yang benar
    },
    {
      'question': 'Contoh soal nomor 2',
      'options': ['Opsi A', 'Opsi B', 'Opsi C', 'Opsi D', 'Opsi E'],
      'answer': 0,
    },
    // Tambahkan pertanyaan lainnya di sini
  ];

  void _checkAnswer(int selectedOption) {
    if (selectedOption == _questions[_currentQuestion]['answer']) {
      _score++;
    }

    if (_currentQuestion == _questions.length - 1) {
      // Kuis selesai, tampilkan skor
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Skor Akhir'),
            content: Text('Skor Anda: $_score/${_questions.length}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CourseDetailPage(courseId: '',), 
                    ),
                  );
                },
                child: const Text('Back'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        _currentQuestion++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quizData['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pertanyaan ${_currentQuestion + 1}/${_questions.length}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              _questions[_currentQuestion]['question'],
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            ..._questions[_currentQuestion]['options']
                .map(
                  (option) => ElevatedButton(
                    onPressed: () => _checkAnswer(
                        _questions[_currentQuestion]['options'].indexOf(option)),
                    child: Text(option),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}