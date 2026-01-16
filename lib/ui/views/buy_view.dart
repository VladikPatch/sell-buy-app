import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sell_buy_app/constants/app_dimensions.dart';
import 'package:sell_buy_app/constants/enums.dart';
import 'package:sell_buy_app/controllers/transaction_controller.dart';
import 'package:sell_buy_app/ui/widgets/countdown_progress_bar.dart';
import 'package:sell_buy_app/ui/widgets/upgrades_grid.dart';
import 'package:sell_buy_app/viewmodels/market_view_model.dart';
import 'package:sell_buy_app/viewmodels/upgrades_view_model.dart';
import 'package:sell_buy_app/viewmodels/user_view_model.dart';

import '../../models/item.dart';
import '../widgets/items_grid.dart';
import '../widgets/market_state_icon.dart';
import '../widgets/total_price_banner.dart';

class BuyView extends ConsumerStatefulWidget {
  static const double _horizontalPadding = 48;
  static const int _totalPriceBannerAnimation = 200;
  static const int _marketStateChangeAnimation = 400;
  static const int _resultStateDuration = 1600;

  const BuyView({super.key});

  @override
  ConsumerState<BuyView> createState() => _BuyViewState();
}

class _BuyViewState extends ConsumerState<BuyView> {
  final Set<int> _selectedIndexes = {};
  int _lastValidTotal = 0;
  int _timerKeySeed = 0;

  @override
  Widget build(BuildContext context) {
    final displayItemsAsync = ref.watch(displayItemsProvider('buyView'));
    final market = ref.watch(marketProvider).value;
    final user = ref.watch(userProvider).value;

    final marketState = market?.marketState ?? MarketState.shopping;
    final upgradesGroup = ref.watch(currentUpgradesGroupProvider);

    return Column(
      children: [
        Expanded(
          child: displayItemsAsync.when(
            data: (displayItems) {
              final currentTotal = _getTotalPrice(
                displayItems,
                market?.buyPrices ?? {},
              );

              if (currentTotal > 0) {
                _lastValidTotal = currentTotal;
              }

              final isEnough = ((user?.balanceCents ?? 0) >= _lastValidTotal);
              final warningColor = isEnough ? null : Colors.red;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: BuyView._horizontalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppDimensions.spacingMedium,
                  children: [
                    AnimatedOpacity(
                      opacity: _selectedIndexes.isNotEmpty ? 1.0 : 0.0,
                      duration: Duration(
                        milliseconds: BuyView._totalPriceBannerAnimation,
                      ),
                      child: TotalPriceBanner(
                        icon: Icons.shopping_cart_outlined,
                        totalPrice: _lastValidTotal,
                        color: warningColor,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(
                        milliseconds: BuyView._marketStateChangeAnimation,
                      ),
                      switchInCurve: Curves.easeInOutQuad,
                      switchOutCurve: Curves.easeInOutQuad,
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: switch (marketState) {
                        MarketState.shopping => ItemsGrid(
                          key: ValueKey('shopping'),
                          displayItems: displayItems,
                          selectedIndexes: _selectedIndexes,
                          prices: market?.buyPrices ?? {},
                          onItemTap: _toggleSelection,
                        ),
                        MarketState.upgrading =>
                          upgradesGroup != null
                              ? UpgradesGrid(
                                  key: ValueKey('upgrading'),
                                  upgradeGroup: upgradesGroup,
                                  onItemTap: (index, item) {},
                                )
                              : Center(child: CircularProgressIndicator()),
                        MarketState.success => MarketStateIcon(
                          key: ValueKey('success'),
                          icon: Icons.check_circle_rounded,
                          iconColor: Colors.green,
                        ),
                        MarketState.skipped => MarketStateIcon(
                          key: ValueKey('skipped'),
                          icon: Icons.next_plan_rounded,
                          iconColor: Colors.grey,
                        ),
                        MarketState.failure => MarketStateIcon(
                          key: ValueKey('failure'),
                          icon: Icons.cancel_rounded,
                          iconColor: Colors.red,
                        ),
                      },
                    ),
                  ],
                ),
              );
            },
            error: (err, stack) => Center(child: Text('$err')),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(
            top: AppDimensions.spacingXLarge,
            bottom: AppDimensions.spacingLarger,
          ),
          child: CountdownProgressBar(
            key: ValueKey(_timerKeySeed),
            onFinished: _onCycleComplete,
          ),
        ),
      ],
    );
  }

  int _getTotalPrice(List<Item> items, Map<String, int> prices) {
    int total = 0;
    for (int i in _selectedIndexes) {
      if (i < items.length) {
        total += prices[items[i].id] ?? 0;
      }
    }
    return total;
  }

  _toggleSelection(int index, Item item) {
    setState(() {
      if (_selectedIndexes.contains(index)) {
        _selectedIndexes.remove(index);
      } else {
        _selectedIndexes.add(index);
      }
    });
  }

  void _onCycleComplete() async {
    final resultState = ref
        .read(transactionControllerProvider)
        .executeBuyCycle(_selectedIndexes);

    ref.read(marketProvider.notifier).setMarketState(resultState);

    setState(() {
      _selectedIndexes.clear();
    });

    await Future.delayed(
      const Duration(milliseconds: BuyView._resultStateDuration),
    );

    if (!mounted) return;

    ref.invalidate(displayItemsProvider('buyView'));
    ref.read(marketProvider.notifier).refreshMarket();

    setState(() {
      _timerKeySeed++;
    });
  }
}
