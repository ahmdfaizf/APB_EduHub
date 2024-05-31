import 'package:edu_hub/page/main_page.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  List<Map<String, dynamic>> items = [
    {'id': 1, 'title': 'Item 1', 'checked': false},
    {'id': 2, 'title': 'Item 2', 'checked': true},
    {'id': 3, 'title': 'Item 3', 'checked': false},
    {'id': 4, 'title': 'Item 4', 'checked': false},
    {'id': 5, 'title': 'Item 5', 'checked': false},
    {'id': 6, 'title': 'Item 6', 'checked': false}
    // tambahkan item lainnya di sini
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
            child: ListTile(
              title: Text(item['title']),
              onTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      ),
            ),
          );
        }
        )
      )
    );
  }
}