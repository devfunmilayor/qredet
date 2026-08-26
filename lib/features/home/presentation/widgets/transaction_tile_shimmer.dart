import 'package:flutter/material.dart';
import 'package:qredet/core/theme/app_spacing.dart';
import 'package:qredet/core/widgets/shimmer_box.dart';

class TransactionTileShimmer extends StatelessWidget {
  const TransactionTileShimmer({super.key, this.count = 4});

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
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          const ShimmerBox(width: 40, height: 40, borderRadius: 20),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerBox(width: 120, height: 14),
                SizedBox(height: 6),
                ShimmerBox(width: 80, height: 12),
              ],
            ),
          ),
          const ShimmerBox(width: 60, height: 14),
        ],
      ),
    );
  }
}
