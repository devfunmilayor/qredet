import 'package:flutter/material.dart';
import '../theme/app_semantic_colors.dart';

class ShimmerBox extends StatefulWidget {
  const ShimmerBox({super.key, required this.width, required this.height, this.borderRadius = 8});

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = context.colors.surfaceAvatar;
    final highlight = context.colors.divider;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final t = _controller.value;
            return LinearGradient(
              colors: [base, highlight, base],
              stops: const [0.35, 0.5, 0.65],
              begin: Alignment(-1 - t * 2, 0),
              end: Alignment(1 - t * 2, 0),
            ).createShader(bounds);
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(color: base, borderRadius: BorderRadius.circular(widget.borderRadius)),
          ),
        );
      },
    );
  }
}
