import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sell_buy_app/core/user/user_provider.dart';
import 'package:sell_buy_app/core/widgets/grid_view_builder.dart';
import 'package:sell_buy_app/features/buy/countdown_progress_bar.dart';

import '../../core/widgets/item_card.dart';
import 'display_items_provider.dart';
import 'item.dart';

class BuyView extends ConsumerStatefulWidget {
  const BuyView({super.key});

  @override
  ConsumerState<BuyView> createState() => _BuyViewState();
}

class _BuyViewState extends ConsumerState<BuyView> {
  @override
  Widget build(BuildContext context) {
    final displayItems = ref.watch(displayItemsProvider('buyView'));

    return Column(
      children: [
        Expanded(
          child: GridViewBuilder(
            itemCount: displayItems.length,
            itemBuilder: (context, i) {
              final item = displayItems[i];

              final ownedCountForThisType = ref.watch(
                userProvider.select(
                  (user) => user.ownedCountsByTypeId[item.typeId] ?? 0,
                ),
              );

              final priorSameTypeCount = displayItems
                  .take(i)
                  .where((it) => it.typeId == item.typeId)
                  .length;

              final ownsItem = priorSameTypeCount < ownedCountForThisType;

              return ItemCard(
                item: item,
                ownsItem: ownsItem,
                onTap: ownsItem
                    ? () {}
                    : () => ref.read(userProvider.notifier).buy(item),
              );
            },
          ),
        ),
        CountdownProgressBar(
          onCycleComplete: () => ref.invalidate(displayItemsProvider),
          height: 8,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
