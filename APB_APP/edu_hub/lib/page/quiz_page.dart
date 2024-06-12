import 'package:edu_hub/page/course_detail_page.dart';
import 'package:edu_hub/services/firestore_course.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final String quizId;
  final String courseId;

  const QuizPage({super.key, required this.quizId, required this.courseId});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestion = 0;
  int _score = 0;
  late List<Map<String, dynamic>> _questions;

  final FirestoreCourseService _firestoreService = FirestoreCourseService();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final questionStream = _firestoreService.getSoals(widget.courseId, widget.quizId);
    questionStream.listen((snapshot) {
      setState(() {
        _questions = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            'pertanyaan': data['pertanyaan'],
            'pilihan1': data['pilihan1'],
            'pilihan2': data['pilihan2'],
            'pilihan3': data['pilihan3'],
            'pilihan4': data['pilihan4'],
            'jawabanBenar': data['jawabanBenar'],
          };
        }).toList();
      });
    });
  }

  void _checkAnswer(String selectedOption) {
    if (selectedOption == _questions[_currentQuestion]['jawabanBenar']) {
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
                  Navigator.of(context).pop();
                  // Arahkan ke halaman detail kursus dengan courseId yang sesuai
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseDetailPage(courseId: widget.courseId),
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
        title: Text(_questions.isNotEmpty ? _questions[0]['pertanyaan'] : 'Quiz'),
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
              _questions[_currentQuestion]['pertanyaan'],
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _checkAnswer(_questions[_currentQuestion]['pilihan1']),
              child: Text(_questions[_currentQuestion]['pilihan1']),
            ),
            ElevatedButton(
              onPressed: () => _checkAnswer(_questions[_currentQuestion]['pilihan2']),
              child: Text(_questions[_currentQuestion]['pilihan2']),
            ),
            ElevatedButton(
              onPressed: () => _checkAnswer(_questions[_currentQuestion]['pilihan3']),
              child: Text(_questions[_currentQuestion]['pilihan3']),
            ),
            ElevatedButton(
              onPressed: () => _checkAnswer(_questions[_currentQuestion]['pilihan4']),
              child: Text(_questions[_currentQuestion]['pilihan4']),
            ),
          ],
        ),
      ),
    );
  }
}