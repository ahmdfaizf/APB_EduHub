import 'package:edu_hub/page/course_quiz_page.dart';
import 'package:edu_hub/page/course_video_page.dart';
import 'package:edu_hub/page/main_page.dart';
import 'package:edu_hub/services/firestore_course.dart';
import 'package:flutter/material.dart';

class CourseDetailPage extends StatefulWidget {
  final String courseId;

  const CourseDetailPage({super.key, required this.courseId});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  int idx = 0;
  late final List<Widget> screens;
  final FirestoreCourseService _firestoreService = FirestoreCourseService();
  String _judul = 'Loading...';
  String _deskripsi = 'Loading...';
  String _urlGambar = '';

  @override
  void initState() {
    super.initState();
    screens = [
      CourseVideoPage(courseId: widget.courseId),
      const CourseQuizPage(courseId: '',),
    ];
    _loadCourseDetails();
  }

  Future<void> _loadCourseDetails() async {
    final course = await _firestoreService.getCourseDetails(widget.courseId);
    setState(() {
      _judul = course.judul;
      _deskripsi = course.deskripsi;
      _urlGambar = course.urlGambar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            builder: (context) => const MainPage(),
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
