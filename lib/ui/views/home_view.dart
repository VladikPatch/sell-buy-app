import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sell_buy_app/extensions/currency_extension.dart';
import 'package:sell_buy_app/ui/views/inventory_view.dart';
import 'package:sell_buy_app/ui/views/sell_view.dart';
import 'package:sell_buy_app/ui/widgets/shared_app_bar.dart';
import 'package:sell_buy_app/viewmodels/user_view_model.dart';

import '../../constants/enums.dart';
import 'buy_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const int animationDurationMilliseconds = 200;

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  HomeTab _currentTab = HomeTab.buy;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).value;

    void onTabChanged(HomeTab newTab) {
      setState(() {
        _currentTab = newTab;
      });
    }

    return Scaffold(
      appBar: SharedAppBar(
        currentTab: _currentTab,
        balance: user?.balanceCents.asCurrency ?? '0.00\$',
        onTabChanged: onTabChanged,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(
          milliseconds: HomeView.animationDurationMilliseconds,
        ),
        child: switch (_currentTab) {
          HomeTab.buy => const BuyView(key: ValueKey('buy')),
          HomeTab.sell => const SellView(key: ValueKey('sell')),
          HomeTab.inventory => const InventoryView(key: ValueKey('inventory')),
        },
      ),
    );
  }
}
