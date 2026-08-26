import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

class NotificationTileShimmer extends StatelessWidget {
  const NotificationTileShimmer({super.key, this.count = 5});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(children: List.generate(count, (_) => const _ShimmerRow()));
  }
}

class _ShimmerRow extends StatelessWidget {
  const _ShimmerRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerBox(width: 40, height: 40, borderRadius: 20),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerBox(width: 140, height: 14),
                SizedBox(height: 8),
                ShimmerBox(width: 200, height: 12),
                SizedBox(height: 8),
                ShimmerBox(width: 80, height: 11),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
