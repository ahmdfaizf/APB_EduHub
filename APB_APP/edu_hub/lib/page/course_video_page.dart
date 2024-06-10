import 'package:edu_hub/page/main_page.dart';
import 'package:flutter/material.dart';

class CourseVideoPage extends StatefulWidget {
  const CourseVideoPage({super.key});

  @override
  State<CourseVideoPage> createState() => _CourseVideoPageState();
}

class _CourseVideoPageState extends State<CourseVideoPage> {
  List<Map<String, dynamic>> items = [
    {
      'id': 1,
      'title': 'Video 1',
      'description': 'Setup Language',
      'image': 'assets/LogoEduHub.png',
      'checked': false
    },
    {
      'id': 2,
      'title': 'Video 2',
      'description': 'HELLO WORLD',
      'image': 'assets/LogoEduHub.png',
      'checked': true
    },
    {
      'id': 3,
      'title': 'Video 3',
      'description': 'Start Using Framework',
      'image': 'assets/LogoEduHub.png',
      'checked': true
    },
    {
      'id': 4,
      'title': 'Video 4',
      'description': 'Hello Flutter',
      'image': 'assets/LogoEduHub.png',
      'checked': true
    },
    {
      'id': 5,
      'title': 'Video 5',
      'description': 'Build a Complex Project With Flutter',
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
                trailing: IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      isScrollControlled: true,
                      builder: (context) => DraggableScrollableSheet(
                        maxChildSize: 0.75,
                        minChildSize: 0.75,
                        initialChildSize: 0.75,
                        expand: false,
                        builder: (context, scrollController) =>
                            VideoPlayerPage(),
                      ),
                    );
                  },
                ),
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

class VideoPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Video Player',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
