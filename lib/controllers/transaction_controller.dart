import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sell_buy_app/constants/enums.dart';

import '../models/item.dart';
import '../viewmodels/market_view_model.dart';
import '../viewmodels/user_view_model.dart';

final transactionControllerProvider = Provider(
  (ref) => TransactionController(ref),
);

class TransactionController {
  final Ref _ref;

  TransactionController(this._ref);

  MarketState executeBuyCycle(Set<int> selectedIndexes) {
    final displayState = _ref.read(displayItemsProvider('buyView'));
    final marketState = _ref.read(marketProvider).value;
    final user = _ref.read(userProvider).value;

    if (!displayState.hasValue || marketState == null || user == null) {
      return MarketState.failure;
    }

    final currentItems = displayState.value!;
    final prices = marketState.buyPrices;

    int totalCost = 0;
    final List<Item> itemsToBuy = [];

    for (int i in selectedIndexes) {
      if (i < currentItems.length) {
        final item = currentItems[i];
        totalCost += prices[item.id] ?? 0;
        itemsToBuy.add(item);
      }
    }

    if (itemsToBuy.isEmpty) return MarketState.skipped;

    if (user.balanceCents >= totalCost) {
      _ref.read(userProvider.notifier).buy(itemsToBuy, totalCost);
      return MarketState.success;
    }

    return MarketState.failure;
  }

  MarketState executeSellCycle(Set<int> selectedIndexes) {
    final displayState = _ref.read(displayItemsProvider('sellView'));
    final marketState = _ref.read(marketProvider).value;

    if (!displayState.hasValue || marketState == null) {
      return MarketState.failure;
    }

    final currentItems = displayState.value!;
    final prices = marketState.sellPrices;

    int totalCost = 0;
    final List<Item> itemsToSell = [];

    for (int i in selectedIndexes) {
      if (i < currentItems.length) {
        final item = currentItems[i];
        totalCost += prices[item.id] ?? 0;
        itemsToSell.add(item);
      }
    }

    if (itemsToSell.isEmpty) return MarketState.skipped;

    _ref.read(userProvider.notifier).sell(itemsToSell, totalCost);

    return MarketState.success;
  }
}
