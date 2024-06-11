import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_hub/models/course_model.dart';

class FirestoreCourseService {
  final CollectionReference _courseCollection =
      FirebaseFirestore.instance.collection('Course');

  // Create
  Future<void> createCourse(String imgUrl, String judul, String deskripsi) async {
    try {
      await _courseCollection.add({
        'urlGambar': imgUrl,
        'judul': judul,
        'deskripsi': deskripsi,
      });
    // ignore: empty_catches
    } catch (e) {
    }
  }

  // Read
  Stream<QuerySnapshot> getCourses() {
    final noteStream =
        _courseCollection.orderBy('judul', descending: true).snapshots();

    return noteStream;
  }

  Future<CourseModel> getCourseDetails(String courseId) async {
    try {
      final doc = await _courseCollection.doc(courseId).get();
      return CourseModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  // Update
  Future<void> updateCourse(String docId, String imgUrl, String judul, String deskripsi) async {
    try {
      await _courseCollection.doc(docId).update({
        'urlGambar': imgUrl,
        'judul': judul,
        'deskripsi': deskripsi,
      });
    // ignore: empty_catches
    } catch (e) {
    }
  }

  // Delete
  Future<void> deleteCourse(String docId) async {
    try {
      await _courseCollection.doc(docId).delete();
    // ignore: empty_catches
    } catch (e) {
    }
  }

  Future<void> createVideo(String courseId, String vidUrl, String judul, String deskripsi) async {
    try {
      await _courseCollection
          .doc(courseId)
          .collection('Video')
          .add({
            'vidUrl': vidUrl,
            'judul': judul,
            'deskripsi': deskripsi,
          });
    // ignore: empty_catches
    } catch (e) {
    }
  }

  // Read
  Stream<QuerySnapshot> getVideos(String courseId) {
    final videoStream = _courseCollection
        .doc(courseId)
        .collection('Video')
        .orderBy('judul', descending: true)
        .snapshots();

    return videoStream;
  }

  // Update
  Future<void> updateVideo(String courseId, String videoId, String vidUrl, String judul, String deskripsi) async {
  try {
    await _courseCollection
        .doc(courseId)
        .collection('Video')
        .doc(videoId)
        .update({
          'vidUrl': vidUrl,
          'judul': judul,
          'deskripsi': deskripsi,
        });
  // ignore: empty_catches
  } catch (e) {
  }
}

  // Delete
  Future<void> deleteVideo(String courseId, String videoId) async {
    try {
      await _courseCollection
          .doc(courseId)
          .collection('Video')
          .doc(videoId)
          .delete();
    // ignore: empty_catches
    } catch (e) {
    }
  }
}
