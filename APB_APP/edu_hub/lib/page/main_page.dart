import 'package:edu_hub/page/account_page.dart';
import 'package:edu_hub/page/course_page.dart';
import 'package:edu_hub/page/note_page.dart';
import 'package:edu_hub/page/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int idx = 0;
  final screen =[
    const HomePage(),
    const CoursePage(),
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
            NavigationDestination(
              icon: Icon(Icons.person, color: Colors.white),
              label: 'Account',
            ),
          ],
        )
      ),
    );
  }
}