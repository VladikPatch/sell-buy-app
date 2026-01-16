import 'package:flutter/material.dart';

import '../../constants/app_dimensions.dart';
import '../../models/item.dart';
import 'item_card.dart';

class InventoryGrid extends StatelessWidget {
  static const int _crossAxisCount = 3;
  static const double _axisSpacing = 8;
  static const double _aspectRatio = 2 / 2.8;
  static const double _cardImageSize = 64.0;

  const InventoryGrid({
    super.key,
    required this.inventoryItems,
    required this.userInventory,
  });

  final List<Item> inventoryItems;
  final Map<String, int>? userInventory;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.spacingLarge,
        horizontal: AppDimensions.spacingMedium,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _crossAxisCount,
        mainAxisSpacing: _axisSpacing,
        crossAxisSpacing: _axisSpacing,
        childAspectRatio: _aspectRatio,
      ),
      itemCount: inventoryItems.length,
      itemBuilder: (context, index) {
        final item = inventoryItems[index];
        return DisplayCard(
          iconPath: item.iconPath,
          title: item.name,
          subtitle: 'x${userInventory?[item.id] ?? 0}',
          imageSize: _cardImageSize,
          onTap: () {},
        );
      },
    );
  }
}
