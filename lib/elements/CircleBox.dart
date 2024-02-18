import 'package:flutter/material.dart';

class CircleBox extends StatelessWidget {
  final double height;
  final double width;
  final Widget widget;
  const CircleBox(
      {super.key,
      required this.height,
      required this.width,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: widget,
    );
  }
}
