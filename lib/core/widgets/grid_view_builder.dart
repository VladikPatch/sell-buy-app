import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/buy/display_items_provider.dart';
import '../user/user_provider.dart';
import 'item_card.dart';

class GridViewBuilder extends ConsumerWidget {
  const GridViewBuilder({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
  });

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(48, 96, 48, 48),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2 / 2.8,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
