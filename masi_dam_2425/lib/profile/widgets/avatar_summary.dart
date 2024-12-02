import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/avatar.dart';
import 'package:masi_dam_2425/plants/widgets/experience_bar.dart';

import 'avatar_icon.dart';

class AvatarSummary extends StatelessWidget {
  final Avatar profile;

  const AvatarSummary({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            AvatarIcon(photo: ''),
            const SizedBox(width: 16), 
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        profile.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(Icons.settings, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.title,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  _levelRow(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _levelRow(BuildContext context) {
    return Row(
      children: [
        // Level Text
        Text(
          'Lvl ${profile.level}',
          style: const TextStyle(fontWeight: FontWeight.bold,
                color: Colors.black87),
        ),
        const SizedBox(width: 8),
        // Experience Bar
        Expanded(
          child: ExperienceBar(
            currentXp: profile.xp,
            maxXp: 100,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
