import 'package:flutter/material.dart';

const _avatarSize = 48.0;

class AvatarIcon extends StatelessWidget {
  const AvatarIcon({super.key, this.photo});

  final String? photo;

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    return CircleAvatar(
      radius: _avatarSize,
      backgroundColor: Colors.black12,
      child: photo == null
            ? Image.asset('assets/warrior.jpg', width: _avatarSize, height: _avatarSize)
          : null,
    );
  }
}
