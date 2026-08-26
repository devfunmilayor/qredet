import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/shimmer_box.dart';

/// Skeleton matching [BalanceHeader] + [VirtualAccountChip]'s layout.
class BalanceShimmer extends StatelessWidget {
  const BalanceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ShimmerBox(width: 110, height: 14),
        const SizedBox(height: AppSpacing.md),
        const ShimmerBox(width: 160, height: 44, borderRadius: 12),
        const SizedBox(height: AppSpacing.lg),
        const ShimmerBox(width: 200, height: 44, borderRadius: AppSpacing.pillRadius),
        const SizedBox(height: AppSpacing.xs),
        const ShimmerBox(width: 90, height: 12),
      ],
    );
  }
}
