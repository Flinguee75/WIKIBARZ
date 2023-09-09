import 'dart:typed_data';

import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  final Uint8List image;
  const UserPhoto({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: Colors.black,
        ),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
          )
        ],
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundImage: MemoryImage(image),
      ),
    );
  }
}
