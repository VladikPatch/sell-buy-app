import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sell_buy_app/core/user/user_provider.dart';
import 'package:sell_buy_app/core/widgets/grid_view_builder.dart';
import 'package:sell_buy_app/features/buy/countdown_progress_bar.dart';

import '../../core/widgets/item_card.dart';
import '../buy/display_items_provider.dart';

class SellView extends ConsumerStatefulWidget {
  const SellView({super.key});

  @override
  ConsumerState<SellView> createState() => _SellViewState();
}

class _SellViewState extends ConsumerState<SellView> {
  @override
  Widget build(BuildContext context) {
    final displayItems = ref.watch(displayItemsProvider('sellView'));

    return Column(
      children: [
        Expanded(
          child: GridViewBuilder(
            itemCount: displayItems.length,
            itemBuilder: (context, i) {
              final item = displayItems[i];

              // final ownsItem = ref.watch(
              //   userProvider.select((user) => user.ownsItemId(item.id)),
              // );

              return ItemCard(item: item, ownsItem: true, onTap: () {});
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
