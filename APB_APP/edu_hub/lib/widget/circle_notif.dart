import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  const CircleButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}