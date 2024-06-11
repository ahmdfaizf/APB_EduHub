import 'package:edu_hub/page/video_player_page.dart';
import 'package:edu_hub/services/firestore_course.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseVideoTeacherPage extends StatefulWidget {
  final String courseId;

  const CourseVideoTeacherPage({super.key, required this.courseId});

  @override
  State<CourseVideoTeacherPage> createState() => _CourseVideoTeacherPageState();
}

class _CourseVideoTeacherPageState extends State<CourseVideoTeacherPage> {
  final FirestoreCourseService _firestoreService = FirestoreCourseService();
  List<Map<String, dynamic>> _videos = [];
  late Map<String, YoutubePlayerController> _videoControllers = {};

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    final videoStream = _firestoreService.getVideos(widget.courseId);
    videoStream.listen((snapshot) {
      setState(() {
        _videos = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return data;
        }).toList();
        _initializeVideoControllers();
      });
    });
  }

  void _initializeVideoControllers() {
    _videoControllers = {};
    for (var video in _videos) {
      final youtubeVideoId = YoutubePlayer.convertUrlToId(video['vidUrl'])!;
      _videoControllers[video['id']] = YoutubePlayerController(
        initialVideoId: youtubeVideoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _videoControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: _videos.length,
          itemBuilder: (context, index) {
            final video = _videos[index];
            return Card(
              color: Colors.white70,
              child: ListTile(
                title: Text(video['judul']),
                subtitle: Text(video['deskripsi']),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.blueGrey,
                      context: context,
                      isDismissible: true,
                      isScrollControlled: true,
                      builder: (context) => DraggableScrollableSheet(
                        maxChildSize: 0.75,
                        minChildSize: 0.75,
                        initialChildSize: 0.75,
                        expand: false,
                        builder: (context, scrollController) => VideoPlayerPage(
                          controller: _videoControllers[video['id']]!,
                        ),
                      ),
                    );
                  },
                ),
                onTap: null,
              ),
            );
          },
        ),
      ),
    );
  }
}
