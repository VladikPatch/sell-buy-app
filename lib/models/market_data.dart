import 'package:sell_buy_app/constants/enums.dart';

import 'item.dart';

class MarketData {
  const MarketData({
    required this.items,
    required this.buyPrices,
    required this.sellPrices,
    required this.marketState,
    required this.cycleLevel,
  });

  final List<Item> items;
  final Map<String, int> buyPrices;
  final Map<String, int> sellPrices;
  final MarketState marketState;
  final int cycleLevel;

  MarketData copyWith({
    List<Item>? items,
    Map<String, int>? buyPrices,
    Map<String, int>? sellPrices,
    MarketState? marketState,
    int? cycleLevel,
  }) {
    return MarketData(
      items: items ?? this.items,
      buyPrices: buyPrices ?? this.buyPrices,
      sellPrices: sellPrices ?? this.sellPrices,
      marketState: marketState ?? this.marketState,
      cycleLevel: cycleLevel ?? this.cycleLevel,
    );
  }
}
