import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/model/avatar.dart';

import '../../inventory/cubit/inventory_cubit.dart';
import '../../plants/widgets/experience_bar.dart';
import '../widgets/avatar_icon.dart';

class ProfileSummaryWidget extends StatelessWidget {
  final Avatar profile;
  final Function? action;

  ProfileSummaryWidget({key, this.action, required this.profile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final wallet = context.select((InventoryCubit cubit) => cubit.state.coins);
    return Card(
        elevation: 2,
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            splashColor: Theme.of(context).primaryColor.withAlpha(30),
            onTap: () {
              if (action != null) {
                action!();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
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
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.settings,
                                          color: Colors.blueGrey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(profile.title,
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "Balance: ${wallet}",
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey)),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.monetization_on, color: Colors.grey, size: 20),

                                  ],
                                )
                              ]))
                    ],
                  ),
                  const SizedBox(height: 16),
                  _levelRow(context),
                ],
              ),
            )));
  }

  Widget _levelRow(BuildContext context) {
    return Row(
      children: [
        // Level Text
        Text(
          'Lvl ${profile.level}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black87),
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