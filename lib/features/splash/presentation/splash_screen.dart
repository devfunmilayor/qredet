import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_semantic_colors.dart';
import '../../../gen/assets.gen.dart';

/// Dumb by design — no manual navigation here. go_router's `redirect`
/// (see `app_router.dart`) moves off this route the moment [AuthBloc]
/// settles on an authenticated/unauthenticated state.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.surfaceBackground,
      body: Center(
        child: Assets.icons.qredetMark
            .svg(width: 72, height: 72)
            .animate()
            .fadeIn(duration: 400.ms)
            .scale(begin: const Offset(0.85, 0.85), end: const Offset(1, 1), curve: Curves.easeOut),
      ),
    );
  }
}
