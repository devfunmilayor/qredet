import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injection.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../language/presentation/widgets/language_pill.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'widgets/balance_section.dart';
import 'widgets/notification_bell.dart';
import 'widgets/primary_button.dart';
import 'widgets/transactions_section.dart';
import 'widgets/upgrade_card.dart';
import 'widgets/upgrade_tiers_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>()..add(const HomeEvent.started()),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  Future<void> _refresh(BuildContext context) {
    context.read<HomeBloc>().add(const HomeEvent.refreshed());
    return context.read<HomeBloc>().stream.firstWhere((s) => !s.isRefreshing);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final content = CustomScrollView(
      slivers: [
        if (Platform.isIOS) CupertinoSliverRefreshControl(onRefresh: () => _refresh(context)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: AppSpacing.lg),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [LanguagePill(), NotificationBell(hasUnread: true)],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
              const SliverToBoxAdapter(child: BalanceSection()),
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
              SliverToBoxAdapter(
                child: UpgradeCard(
                  title: l10n.upgradeAccountTitle,
                  subtitle: l10n.upgradeAccountSubtitle,
                  onTap: () => UpgradeTiersSheet.show(context),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
              TransactionsSection(onSeeAll: () => context.push(AppRoutes.transactions)),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Platform.isIOS ? content : RefreshIndicator(onRefresh: () => _refresh(context), child: content),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: PrimaryButton(label: l10n.makePayment, onPressed: () {}),
      ),
    );
  }
}
