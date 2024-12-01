import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/avatar.dart';
import 'package:masi_dam_2425/plants/widgets/experience_bar.dart';
import 'package:masi_dam_2425/profile/view/profile_page.dart';

import 'avatar_icon.dart';

class AvatarSummary extends StatelessWidget {
  
  final Avatar profile;

  const AvatarSummary({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AvatarIcon(photo: ''),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(profile.name),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                    },
                    icon: const Icon(Icons.settings))
              ],
            ),
            Text(profile.title),
            _levelRow()
          ],
        )
      ],
    );
  }

  Widget _levelRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Lvl ${profile}'),
        ExperienceBar(
          currentXp: profile.xp,
          maxXp: 100,
          color: Colors.blue,
        )
      ],
    );
  }

}