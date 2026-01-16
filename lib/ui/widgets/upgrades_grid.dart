import 'package:flutter/material.dart';
import 'package:sell_buy_app/constants/app_dimensions.dart';
import 'package:sell_buy_app/extensions/currency_extension.dart';
import 'package:sell_buy_app/models/item.dart';

import '../../models/upgrade.dart';
import 'item_card.dart';

class UpgradesGrid extends StatelessWidget {
  const UpgradesGrid({
    super.key,
    required this.upgradeGroup,
    required this.onItemTap,
  });

  final UpgradesGroup upgradeGroup;
  final void Function(int index, Item item) onItemTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: GridDimensions.delegate,
      itemCount: 2,
      itemBuilder: (context, index) {
        final option = index == 0
            ? upgradeGroup.upgradeA
            : upgradeGroup.upgradeB;

        return DisplayCard(
          iconPath: option.iconPath,
          title: option.name,
          subtitle: option.priceCents.asCurrency,
          onTap: () {},
        );
      },
    );
  }
}
