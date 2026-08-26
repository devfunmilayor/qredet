import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TapScale extends StatefulWidget {
  const TapScale({super.key, required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  State<TapScale> createState() => _TapScaleState();
}

class _TapScaleState extends State<TapScale> {
  bool _pressed = false;

  void _setPressed(bool value) => setState(() => _pressed = value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapCancel: () => _setPressed(false),
      onTapUp: (_) => _setPressed(false),
      onTap: widget.onTap,
      child: widget.child
          .animate(target: _pressed ? 1 : 0)
          .scaleXY(begin: 1, end: 0.9, duration: 100.ms, curve: Curves.easeOut),
    );
  }
}
