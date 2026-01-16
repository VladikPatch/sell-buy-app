import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sell_buy_app/models/upgrade.dart';
import 'package:sell_buy_app/repositories/upgrades_repository.dart';
import 'package:sell_buy_app/viewmodels/market_view_model.dart';
import 'package:sell_buy_app/viewmodels/user_view_model.dart';

final upgradesRepositoryProvider = Provider((ref) => UpgradesRepository());

final allUpgradesProvider = FutureProvider<List<UpgradesGroup>>((ref) async {
  final repository = ref.read(upgradesRepositoryProvider);
  return repository.loadUpgrades();
});

final currentUpgradesGroupProvider = Provider<UpgradesGroup?>((ref) {
  final upgradesAsync = ref.watch(allUpgradesProvider);
  final user = ref.watch(userProvider).value;

  if (user == null || !upgradesAsync.hasValue) {
    return null;
  }

  final allUpgrades = upgradesAsync.value!;

  final marketCycleLevel = ref.watch(marketProvider).value?.cycleLevel ?? 0;

  try {
    return allUpgrades.firstWhere(
      (group) => group.cycleLevel == marketCycleLevel,
    );
  } catch (e) {
    return null;
  }
});
