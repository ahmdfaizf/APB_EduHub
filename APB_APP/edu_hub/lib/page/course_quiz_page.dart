import 'package:edu_hub/page/main_page.dart';
import 'package:flutter/material.dart';

class CourseQuizPage extends StatefulWidget {
  const CourseQuizPage({super.key});

  @override
  State<CourseQuizPage> createState() => _CourseQuizPageState();
}

class _CourseQuizPageState extends State<CourseQuizPage> {
  List<Map<String, dynamic>> items = [
    {
      'id': 1,
      'title': 'Quiz 1',
      'description': '1 Attempt',
      'image': 'assets/LogoEduHub.png',
      'checked': false
    },
    {
      'id': 2,
      'title': 'Quiz 2',
      'description': '1 Attempt',
      'image': 'assets/LogoEduHub.png',
      'checked': true
    },
    {
      'id': 3,
      'title': 'Quiz 3',
      'description': '1 Attempt',
      'image': 'assets/LogoEduHub.png',
      'checked': true
    },
    {
      'id': 4,
      'title': 'Quiz 4',
      'description': '1 Attempt',
      'image': 'assets/LogoEduHub.png',
      'checked': true
    },
    {
      'id': 5,
      'title': 'Quiz 5',
      'description': '1 Attempt',
      'image': 'assets/LogoEduHub.png',
      'checked': true
    },

    // Add more items here
  ];

  void toggleChecked(int id) {
    setState(() {
      items = items.map((item) {
        if (item['id'] == id) {
          item['checked'] = !item['checked'];
        }
        return item;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              color: Colors.white70,
              child: ListTile(
                leading: Image.asset(item['image']),
                title: Text(item['title']),
                subtitle: Text(item['description']),
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
