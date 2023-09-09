import 'package:flutter/material.dart';

class CurrentImage extends StatelessWidget {
  final String path;
  const CurrentImage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: const Color.fromARGB(255, 126, 125, 125),
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
        backgroundImage: path != ""
            ? NetworkImage(path)
            : const NetworkImage(
                ' https://th.bing.com/th/id/OIP.EILQYpqwarBg2w9zy4Ar9gHaFb?w=288&h=212&c=7&r=0&o=5&dpr=1.1&pid=1.7'),
      ),
    );
  }
}
