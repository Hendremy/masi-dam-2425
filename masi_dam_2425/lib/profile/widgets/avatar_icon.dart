import 'package:flutter/material.dart';

const _avatarSize = 48.0;

class AvatarIcon extends StatelessWidget {
  const AvatarIcon({super.key, this.photo});

  final String? photo;

  @override
  Widget build(BuildContext context) {
    final placeholderImage = 'assets/warrior.jpg';
    final hasPhoto = photo != null && photo!.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.blueGrey, // You can change the border color if needed
          width: 2.0, // Border width
        ),
      ),
      child: CircleAvatar(
        radius: _avatarSize,
        backgroundColor: Colors.black12,
        backgroundImage: hasPhoto ? NetworkImage(photo!) : null, // Use network image if available
        child: !hasPhoto
            ? Image.asset(
                placeholderImage, // Ensure it fills the circle
                fit: BoxFit.contain, // Make sure the image covers the entire area
              )
            : null,
      ),
    );
  }
}
