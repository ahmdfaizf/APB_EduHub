import 'package:edu_hub/page/course_quiz_page.dart';
import 'package:edu_hub/page/course_video_page.dart';
import 'package:flutter/material.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  int idx = 0;
  final screens = [
    const CourseVideoPage(),
    const CourseQuizPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey,
              child: const Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Text(
                      'DART COURSE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Learn About Dart and Start Develop Mobile Project',
                      style: TextStyle(
                        color: Colors.white, // fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 60.0)
                  ],
                ),
              ),
            ),
            NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: Colors.transparent,
                indicatorShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
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
                    icon: Icon(Icons.download, color: Colors.black),
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