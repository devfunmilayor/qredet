import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_semantic_colors.dart';
import '../../../gen/assets.gen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.surfaceBackground,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 108,
              height: 108,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: colors.primary,
              ),
            ),
            Assets.icons.qredetMark
                .svg(
                  color: colors.primary,
                  width: 64, height: 64)
                .animate()
                .fadeIn(duration: 400.ms)
                .scale(
                  begin: const Offset(0.85, 0.85),
                  end: const Offset(1, 1),
                  curve: Curves.easeOut,
                ),
          ],
        ),
      ),
    );
  }
}
