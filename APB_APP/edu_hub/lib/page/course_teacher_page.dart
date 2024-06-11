import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_hub/constant/colors.dart';
import 'package:edu_hub/page/course_detail_teacher_page.dart';
import 'package:edu_hub/services/firestore_course.dart';
import 'package:flutter/material.dart';

class CourseTeacherPage extends StatefulWidget {
  const CourseTeacherPage({super.key});

  @override
  State<CourseTeacherPage> createState() => _CourseTeacherPageState();
}

class _CourseTeacherPageState extends State<CourseTeacherPage> {
  final FirestoreCourseService firestore = FirestoreCourseService();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController imgUrlController = TextEditingController();
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
              controller: imgUrlController,
              decoration: const InputDecoration(
                hintText: 'Enter image URL',
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
                firestore.createCourse(
                  imgUrlController.text,
                  judulController.text,
                  deskripsiController.text,
                );
              } else {
                // Add your logic to update the course here
                firestore.updateCourse(
                  docIDs,
                  imgUrlController.text,
                  judulController.text,
                  deskripsiController.text,
                );
              }
              imgUrlController.clear();
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
                                CourseDetailTeacherPage(courseId: courseId),
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
