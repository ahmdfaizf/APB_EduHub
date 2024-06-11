import 'package:edu_hub/page/account_page.dart';
import 'package:edu_hub/page/course_teacher_page.dart';
import 'package:edu_hub/page/note_page.dart';
import 'package:flutter/material.dart';

class MainTeacherPage extends StatefulWidget {
  const MainTeacherPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainTeacherPageState createState() => _MainTeacherPageState();
}

class _MainTeacherPageState extends State<MainTeacherPage> {
  int idx = 0;
  final screen =[
    const CourseTeacherPage(),
    const NotePage(),
    const AccountPage()
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[idx],
      bottomNavigationBar:NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
        child: NavigationBar(
          height: 60,
          selectedIndex: idx,
          onDestinationSelected: (idx) => 
            setState(() => this.idx = idx),
          backgroundColor: Colors.blueGrey,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home, color: Colors.white),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.book, color: Colors.white,),
              label: 'Course',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat, color: Colors.white),
              label: 'Forum',
            ),
          ],
        )
      ),
    );
  }
}