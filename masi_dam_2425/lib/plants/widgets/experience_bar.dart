import 'package:flutter/material.dart';

class ExperienceBar extends StatelessWidget {
  final double currentXp;
  final double maxXp;
  final Color color;

  const ExperienceBar(
      {super.key,
      required this.currentXp,
      required this.maxXp,
      required this.color});

  @override
  Widget build(BuildContext context) {
    double experiencePercentage =
        (currentXp / maxXp).clamp(0.0, 1.0); // Ensures value is between 0 and 1

    return Center(
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 10,
        width: double.infinity,
        child: LinearProgressIndicator(
          //Here you pass the percentage
          value: experiencePercentage,
          color: color,
          backgroundColor: Colors.blue.withAlpha(50),
          minHeight: 2,
        ),
      ),
    );
  }
}
