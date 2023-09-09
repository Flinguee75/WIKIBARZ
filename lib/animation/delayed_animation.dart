import 'package:flutter/material.dart';
import 'dart:async';

class Delayed_animation extends StatefulWidget {
  final Widget child;
  final int delay;
  const Delayed_animation({super.key, required this.delay, required this.child});

  @override
  State<Delayed_animation> createState() => _Delayed_animationState();
}

class _Delayed_animationState extends State<Delayed_animation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    final curve =
        CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _animOffset = Tween<Offset>(
      begin: const Offset(0, -0.35),
      end: Offset.zero,
    ).animate(curve);
    Timer(
      Duration(milliseconds: widget.delay),
      () {
        _controller.forward();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
