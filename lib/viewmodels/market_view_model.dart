import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sell_buy_app/constants/enums.dart';
import 'package:sell_buy_app/models/market_data.dart';

import '../models/item.dart';
import '../repositories/items_repository.dart';
import '../services/market_service.dart';

final itemsRepositoryProvider = Provider((ref) => ItemsRepository());
final marketServiceProvider = Provider((ref) => MarketService());

final marketProvider = AsyncNotifierProvider<MarketNotifier, MarketData>(() {
  return MarketNotifier();
});

class MarketNotifier extends AsyncNotifier<MarketData> {
  @override
  Future<MarketData> build() async {
    return _loadMarket();
  }

  void setMarketState(MarketState newState) {
    if (state.value != null) {
      state = AsyncData(state.value!.copyWith(marketState: newState));
    }
  }

  Future<MarketData> _loadMarket() async {
    final repository = ref.read(itemsRepositoryProvider);
    final service = ref.read(marketServiceProvider);

    final items = await repository.loadItems();

    final buyPrices = service.generatePrices(items, baseMultiplier: 1.0);
    final sellPrices = service.generatePrices(items, baseMultiplier: 0.8);

    // final upgradesGroup = ref.read(currentUpgradesGroupProvider);
    // final upgradeTime = service.rollForUpgradePhase();
    // final isTimeToUpgrade = ((upgradesGroup != null) && upgradeTime);
    // final initialState = isTimeToUpgrade
    //     ? MarketState.upgrading
    //     : MarketState.shopping;

    final initialState = MarketState.shopping;

    final int cycleLevel = state.value?.cycleLevel ?? 0;

    return MarketData(
      items: items,
      buyPrices: buyPrices,
      sellPrices: sellPrices,
      marketState: initialState,
      cycleLevel: cycleLevel,
    );
  }

  Future<void> refreshMarket() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadMarket());
  }
}

final displayItemsProvider = FutureProvider.family<List<Item>, String>((
  ref,
  viewId,
) async {
  final repository = ref.watch(itemsRepositoryProvider);
  final allItems = await repository.loadItems();

  final service = ref.watch(marketServiceProvider);

  return service.getRandomItems(allItems, 4);
});
