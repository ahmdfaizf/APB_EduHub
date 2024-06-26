import 'package:edu_hub/constant/colors.dart';
import 'package:edu_hub/services/firestore_course.dart';
import 'package:flutter/material.dart';

class HomeTeacherPage extends StatefulWidget {
  const HomeTeacherPage({super.key});

  @override
  State<HomeTeacherPage> createState() => _HomeTeacherPageState();
}

class _HomeTeacherPageState extends State<HomeTeacherPage> {
  final TextEditingController judulController = TextEditingController();
  final TextEditingController imgUrlController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final FirestoreCourseService firestore = FirestoreCourseService();

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

      body: const SafeArea(
        child: Text("HOME GURU"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}