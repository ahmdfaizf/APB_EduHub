import 'package:edu_hub/constant/colors.dart';
import 'package:edu_hub/page/course_quiz_page.dart';
import 'package:edu_hub/page/course_video_page.dart';
import 'package:edu_hub/page/main_teacher_page.dart';
import 'package:edu_hub/services/firestore_course.dart';
import 'package:flutter/material.dart';

class CourseDetailTeacherPage extends StatefulWidget {
  final String courseId;

  const CourseDetailTeacherPage({super.key, required this.courseId});

  @override
  State<CourseDetailTeacherPage> createState() => _CourseDetailTeacherPageState();
}

class _CourseDetailTeacherPageState extends State<CourseDetailTeacherPage> {
  int idx = 0;
  late final List<Widget> screens;
  final FirestoreCourseService _firestoreService = FirestoreCourseService();
  String _judul = 'Loading...';
  String _deskripsi = 'Loading...';
  String _urlGambar = '';  // Tambahkan field untuk URL gambar

  final TextEditingController judulController = TextEditingController();
  final TextEditingController vidUrlController = TextEditingController(); // Mengubah nama controller
  final TextEditingController deskripsiController = TextEditingController();

  void openNoteBox(BuildContext context, {String? docIDs}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: judulController,
              decoration: const InputDecoration(
                hintText: 'Enter title',
              ),
            ),
            TextField(
              controller: vidUrlController,
              decoration: const InputDecoration(
                hintText: 'Enter video URL', // Mengubah hint text
              ),
            ),
            TextField(
              controller: deskripsiController,
              decoration: const InputDecoration(
                hintText: 'Enter description',
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docIDs == null) {
                _firestoreService.createVideo(
                  widget.courseId,
                  vidUrlController.text,
                  judulController.text,
                  deskripsiController.text,
                );
              } else {
                _firestoreService.updateVideo(
                  widget.courseId,
                  docIDs,
                  vidUrlController.text,
                  judulController.text,
                  deskripsiController.text,
                );
              }
              vidUrlController.clear();
              judulController.clear();
              deskripsiController.clear();
              Navigator.pop(context);
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppPalet.primary),
              textStyle: MaterialStatePropertyAll(
                TextStyle(color: AppPalet.secondary),
              ),
            ),
            child: const Text(
              "add",
              style: TextStyle(
                color: AppPalet.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    screens = [
      CourseVideoPage(courseId: widget.courseId),
      const CourseQuizPage(),
    ];
    _loadCourseDetails();
  }

  Future<void> _loadCourseDetails() async {
    final course = await _firestoreService.getCourseDetails(widget.courseId);
    setState(() {
      _judul = course.judul;
      _deskripsi = course.deskripsi;
      _urlGambar = course.urlGambar;  // Set URL gambar dari data course
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox(context),
        backgroundColor: AppPalet.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 400,
              decoration: BoxDecoration(
                image: _urlGambar.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(_urlGambar),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: Colors.blueGrey,
              ),
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainTeacherPage(),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(Icons.arrow_drop_up, color: Colors.white, size: 50,),
                      ),
                    ),
                    Text(
                      _judul,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      _deskripsi,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 60.0),
                  ],
                ),
              ),
            ),
            NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: Colors.transparent,
                indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              ),
              child: NavigationBar(
                shadowColor: Colors.black,
                height: 45,
                selectedIndex: idx,
                onDestinationSelected: (idx) => setState(() => this.idx = idx),
                backgroundColor: Colors.white70,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.video_library, color: Colors.black),
                    label: 'Video',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.quiz, color: Colors.black),
                    label: 'Quiz',
                  ),
                ],
              ),
            ),
            Expanded(
              child: screens[idx],
            ),
          ],
        ),
      ),
    );
  }
}
