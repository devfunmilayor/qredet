import '../../domain/entities/upgrade_tier.dart';

/// Static mock tiers shown in the upgrade sheet — no backend for this yet.
const List<UpgradeTier> upgradeTiers = [
  UpgradeTier(name: 'Basic', price: 'Free', limitDescription: '50.000F monthly limit'),
  UpgradeTier(name: 'Standard', price: '2.000F/mo', limitDescription: '500.000F monthly limit'),
  UpgradeTier(name: 'Premium', price: '5.000F/mo', limitDescription: 'No transaction or balance limits'),
];
