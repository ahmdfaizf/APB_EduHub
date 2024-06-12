import 'package:edu_hub/page/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:edu_hub/models/quiz_model.dart';
import 'package:edu_hub/services/firestore_course.dart';

class CourseQuizPage extends StatefulWidget {
  final String courseId;

  const CourseQuizPage({super.key, required this.courseId});

  @override
  State<CourseQuizPage> createState() => _CourseQuizPageState();
}

class _CourseQuizPageState extends State<CourseQuizPage> {
  final FirestoreCourseService _firestoreService = FirestoreCourseService();
  List<QuizModel> _quizzes = [];
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _attemptController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadQuizzes();
  }

  Future<void> _loadQuizzes() async {
    final quizStream = _firestoreService.getQuizzes(widget.courseId);
    quizStream.listen((snapshot) {
      setState(() {
        _quizzes = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return QuizModel.fromJson(data);
        }).toList();
      });
    });
  }

  void _showCreateQuizDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Buat Kuis Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _judulController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan Judul Kuis',
                ),
              ),
              TextField(
                controller: _attemptController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan Attempt',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final quizModel = QuizModel(
                  judul: _judulController.text,
                  nilai: 0.0,
                  attempt: int.tryParse(_attemptController.text) ?? 0,
                  courseId: widget.courseId,
                );
                _firestoreService.createQuiz(widget.courseId, quizModel);
                _judulController.clear();
                _attemptController.clear();
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showAddSoalDialog(String quizId) {
    final TextEditingController _soalController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Soal Baru'),
          content: TextField(
            controller: _soalController,
            decoration: const InputDecoration(
              hintText: 'Masukkan Soal',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                // Logika untuk menambahkan soal baru
                final soalModel = QuizModel(
                  judul: _soalController.text,
                  nilai: 0.0,
                  attempt: 0,
                  courseId: widget.courseId,
                );
                _firestoreService.createSoal(widget.courseId, quizId, soalModel);
                _soalController.clear();
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _showCreateQuizDialog,
          child: const Text('Buat Kuis Baru'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _quizzes.length,
            itemBuilder: (context, index) {
              final quiz = _quizzes[index];
              return Card(
                color: Colors.white70,
                child: ListTile(
                  leading: Image.asset('assets/LogoEduHub.png'),
                  title: Text(quiz.judul),
                  subtitle: Text('${quiz.attempt} Attempt'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      _showAddSoalDialog(quiz.courseId);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QuizPage(courseId: widget.courseId, quizId: quiz.courseId),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
