import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_hub/page/course_detail_page.dart';
import 'package:edu_hub/services/firestore_course.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final FirestoreCourseService firestore = FirestoreCourseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.getCourses(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> courseList = snapshot.data!.docs;

              return ListView.builder(
                itemCount: courseList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = courseList[index];
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String judulCourse = data['judul'];
                  String urlImg = data['urlGambar'];
                  String deskripsiCourse = data['deskripsi'];

                  return Card(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Image.network(urlImg),
                      title: Text(judulCourse),
                      subtitle: Text(deskripsiCourse),
                      onTap: () {
                        // Mendapatkan courseId dari data course yang dipilih
                        String courseId = document
                            .id; // Atau cara lain untuk mendapatkan courseId

                        // Navigasi ke CourseDetailPage dengan meneruskan courseId
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CourseDetailPage(courseId: courseId),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return const Center(
                child: Text("Tidak Ada Course"),
              );
            }
          },
        ),
      ),
    );
  }
}
