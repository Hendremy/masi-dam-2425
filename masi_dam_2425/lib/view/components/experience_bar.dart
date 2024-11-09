import 'package:flutter/material.dart';

class ExperienceBar extends StatelessWidget {
  final double currentXp;
  final double maxXp;

  const ExperienceBar({
    Key? key,
    required this.currentXp,
    required this.maxXp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double experiencePercentage = (currentXp / maxXp).clamp(0.0, 1.0); // Ensures value is between 0 and 1

    return Center(
  child: Container(
    clipBehavior: Clip.hardEdge,
    margin: const EdgeInsets.symmetric(horizontal: 20.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
    ),
    height: 20.0,
    width: double.infinity,
          child: LinearProgressIndicator(
            //Here you pass the percentage
            value: experiencePercentage,
            color: Colors.blue.withAlpha(100),
            backgroundColor: Colors.blue.withAlpha(50),
            minHeight: 2,
          ),
        ),
);
  }
}
