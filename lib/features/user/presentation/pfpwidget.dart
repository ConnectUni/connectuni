import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {

  final ImageProvider? image;
  final VoidCallback? onEditIconTap;

  const ProfileWidget({super.key,
    this.image,
    this.onEditIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: image ?? const AssetImage('assets/default_image.png'), // Provide a default image asset path
          radius: 60,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onEditIconTap,
            child: const CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 15,
              child: Icon(Icons.edit, color: Colors.white, size: 20),
            ),
          ),
        )
      ],
    );
  }
}