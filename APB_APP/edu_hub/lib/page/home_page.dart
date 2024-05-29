import 'package:edu_hub/widget/carousel.dart';
import 'package:edu_hub/widget/circle_notif.dart';
import 'package:edu_hub/widget/list_timeline.dart';
import 'package:edu_hub/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            HeaderBar(),
            Body()
          ],
        ),
      ),
    );
  }
}

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: const Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hello, \nGood Morning',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              CircleButton(icon: Icons.notifications,)
            ],
          ),
          SizedBox(height: 20,),
          SearchTextField()
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Explore Course",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextButton(
                onPressed: null,
                child: Text(
                  "See All",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 250,
          child: Carousel(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Timeline",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextButton(
                onPressed: null,
                child: Text(
                  "See All",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 230,
          child: ScrollableList(),
        )
      ],
    );
  }
}