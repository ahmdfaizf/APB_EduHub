import 'package:flutter/material.dart';

class ScrollableList extends StatelessWidget {
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
  ];

  ScrollableList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.white,
            thickness: 1.0,
          ),
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(
                Icons.circle,
                color: Colors.white,
              ),
              title: Text(
                items[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}