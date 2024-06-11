import 'package:edu_hub/page/video_player_page.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
      'videoUrl': 'https://www.youtube.com/watch?v=-9Bf7uh0VNw',
      'checked': false
    },
  ];

  late Map<int, YoutubePlayerController> videoControllers = {};

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
  void initState() {
    super.initState();
    for (var item in items) {
      final youtubeVideoId = YoutubePlayer.convertUrlToId(item['videoUrl'])!;
      videoControllers[item['id']] = YoutubePlayerController(
        initialVideoId: youtubeVideoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false, // Set autoPlay to false by default
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in videoControllers.values) {
      controller.dispose();
    }
    super.dispose();
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
                          controller: videoControllers[item['id']]!,
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