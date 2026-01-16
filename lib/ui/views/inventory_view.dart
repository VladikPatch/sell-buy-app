import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sell_buy_app/ui/widgets/inventory_grid.dart';
import 'package:sell_buy_app/viewmodels/inventory_view_model.dart';
import 'package:sell_buy_app/viewmodels/user_view_model.dart';

class InventoryView extends ConsumerWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryItems = ref.watch(inventoryItemsProvider);
    final userInventory = ref.watch(userProvider).value?.inventory;

    return InventoryGrid(
      inventoryItems: inventoryItems,
      userInventory: userInventory,
    );
  }
}
