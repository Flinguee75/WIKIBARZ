import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String username;
  final String barz;
  final String imagepath;
  final String image;
  const WallPost(
      {super.key,
      required this.username,
      required this.barz,
      required this.imagepath,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 25,
        left: 15,
        right: 15,
      ),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 103, 103, 103),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(imagepath),
                  )),
              const SizedBox(
                width: 15,
              ),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            barz,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Center(
              child: Container(
            margin: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                image,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
