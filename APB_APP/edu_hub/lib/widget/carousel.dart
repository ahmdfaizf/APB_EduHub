import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1513258496099-48168024aec0?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1488190211105-8b0e65b80b4e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1501504905252-473c47e087f8?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
];

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentPage = 0;

  final List<Widget> imageSliders = imgList.map((item) => Container(
    margin: const EdgeInsets.all(5.0),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      child: Stack(
        children: <Widget>[
          Image.network(item, fit: BoxFit.cover, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            ),
          ),
        ],
      ),
    ),
  )).toList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
              initialPage: 0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              autoPlayCurve: Curves.decelerate,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              onPageChanged: (value, _) {
                setState(() {
                  _currentPage = value;
                });
              }
            ),
          ),
          buildCarouselIndicator(),
        ],
      )
    );
  }

  Widget buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList.asMap().entries.map((entry) {
        return Container(
          margin: const EdgeInsets.all(5),
          height: entry.key == _currentPage ? 7 : 5,
          width: entry.key == _currentPage ? 7 : 5,
          decoration: BoxDecoration(
            color: entry.key == _currentPage ? Colors.black : Colors.blueGrey,
            shape: BoxShape.circle,
          ),
        );
      }).toList(),
    );
  }
}