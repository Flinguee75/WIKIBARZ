import 'package:flutter/material.dart';

/// Flutter code sample for [FadeTransition].

class FadeTransitionExample extends StatefulWidget {
  final Color color;
  final Image image;
  const FadeTransitionExample(
      {super.key, required this.color, required this.image});

  @override
  State<FadeTransitionExample> createState() => _FadeTransitionExampleState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _FadeTransitionExampleState extends State<FadeTransitionExample>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(
      seconds: 2,
    ),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: widget.color,
      child: FadeTransition(
        opacity: _animation,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: widget.image,

          ///Mettre Titre1 ou Titre2
        ),
      ),
    );
  }
}
