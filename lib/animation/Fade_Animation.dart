import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class fadeIn_fadeOut extends StatelessWidget {
  final Widget image;
  final int delay;
  const fadeIn_fadeOut({super.key, required this.image, required this.delay});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      animate: true,
      duration: Duration(
        seconds: delay,
      ),
      child: FadeOut(
        animate: false,
        delay: const Duration(seconds: 2),
        duration: const Duration(seconds: 1),

        // Just change the Image.asset widget to anything you want to fade in/out:
        child: image,
      ), //Image.asset
    );
  }
}
