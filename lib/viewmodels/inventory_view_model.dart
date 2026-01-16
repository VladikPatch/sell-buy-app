import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sell_buy_app/models/item.dart';
import 'package:sell_buy_app/viewmodels/market_view_model.dart';
import 'package:sell_buy_app/viewmodels/user_view_model.dart';

final inventoryItemsProvider = Provider<List<Item>>((ref) {
  final user = ref.watch(userProvider).value;
  final allItemsAsync = ref.watch(displayItemsProvider('buyView'));

  if (user == null || !allItemsAsync.hasValue) {
    return [];
  }

  final allItems = allItemsAsync.value!;
  final inventoryMap = user.inventory;

  return allItems.where((item) {
    return inventoryMap.containsKey(item.id);
  }).toList();
});
