import 'package:flutter/material.dart';

class Textbox extends StatelessWidget {
  final String text;
  final String sectionName;
  final Function()? onPressed;
  const Textbox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: const EdgeInsets.only(
        left: 20,
        top: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onPressed,
              ),
            ],
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
