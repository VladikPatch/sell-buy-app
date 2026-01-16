import 'package:flutter/material.dart';
import 'package:sell_buy_app/extensions/currency_extension.dart';
import 'package:sell_buy_app/models/item.dart';

import 'item_card.dart';

class ItemsGrid extends StatelessWidget {
  static const int _crossAxisCount = 2;
  static const double _axisSpacing = 8;
  static const double _aspectRatio = 2 / 2.8;

  const ItemsGrid({
    super.key,
    required this.displayItems,
    required this.selectedIndexes,
    required this.prices,
    required this.onItemTap,
    this.inventory = const {},
  });

  final List<Item> displayItems;
  final Set<int> selectedIndexes;
  final Map<String, int> prices;
  final Map<String, int> inventory;
  final void Function(int index, Item item) onItemTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _crossAxisCount,
        mainAxisSpacing: _axisSpacing,
        crossAxisSpacing: _axisSpacing,
        childAspectRatio: _aspectRatio,
      ),
      itemCount: displayItems.length,
      itemBuilder: (context, index) {
        final item = displayItems[index];
        final price = prices[item.id] ?? 0;

        final isSelected = selectedIndexes.contains(index);

        final ownedCount = inventory[item.id] ?? 0;
        final isOwned = ownedCount > 0;

        return DisplayCard(
          iconPath: item.iconPath,
          title: item.name,
          subtitle: price.asCurrency,
          isSelected: isSelected,
          isOwned: isOwned,
          onTap: () => onItemTap(index, item),
        );
      },
    );
  }
}
