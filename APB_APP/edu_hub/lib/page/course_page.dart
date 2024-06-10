import 'package:edu_hub/page/course_detail_page.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
 List<Map<String, dynamic>> items = [
    {
      'id': 1,
      'title': 'Item 1',
      'description': 'Description for Item 1',
      'image': 'assets/LogoEduHub.png',
      'checked': false
    },
    {
      'id': 2,
      'title': 'Item 2',
      'description': 'Description for Item 2',
      'image': 'assets/LogoEduHub.png',
      'checked': true
    },
    {
      'id': 3,
      'title': 'Item 2',
      'description': 'Description for Item 2',
      'image': 'assets/LogoEduHub.png',
      'checked': true
    },
    {
      'id': 4,
      'title': 'Item 2',
      'description': 'Description for Item 2',
      'image': 'assets/LogoEduHub.png',
      'checked': true
    },
    {
      'id': 5,
      'title': 'Item 2',
      'description': 'Description for Item 2',
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
                MaterialPageRoute(builder: (context) => const CourseDetailPage()),
              ),
            ),
          );
        },
      ),
    ),
  );
}
}