import 'dart:math';

import '../models/item.dart';

class MarketService {
  static const double _upgradeChance = 0.3;
  final Random _random = Random();

  List<Item> getRandomItems(List<Item> allItems, int count) {
    if (allItems.isEmpty) return [];

    final shuffled = List<Item>.from(allItems)..shuffle(_random);

    return shuffled.take(count).toList();
  }

  Map<String, int> generatePrices(
    List<Item> items, {
    required double baseMultiplier,
  }) {
    final Map<String, int> priceMap = {};

    for (var item in items) {
      final fluctuation = 0.8 + (_random.nextDouble() * 0.4);
      final double rawPrice = item.priceCents * fluctuation * baseMultiplier;
      priceMap[item.id] = rawPrice < 1 ? 1 : rawPrice.round();
    }

    return priceMap;
  }

  bool rollForUpgradePhase() {
    return _random.nextDouble() < _upgradeChance;
  }
}
