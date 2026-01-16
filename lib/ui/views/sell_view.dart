import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sell_buy_app/constants/app_dimensions.dart';
import 'package:sell_buy_app/controllers/transaction_controller.dart';
import 'package:sell_buy_app/ui/widgets/countdown_progress_bar.dart';
import 'package:sell_buy_app/ui/widgets/total_price_banner.dart';
import 'package:sell_buy_app/viewmodels/market_view_model.dart';
import 'package:sell_buy_app/viewmodels/user_view_model.dart';

import '../../constants/enums.dart';
import '../../models/item.dart';

class SellView extends ConsumerStatefulWidget {
  static const double _horizontalPadding = 48;
  static const int _totalPriceBannerAnimation = 200;
  static const int _marketStateChangeAnimation = 400;
  static const int _successStateDuration = 1600;

  const SellView({super.key});

  @override
  ConsumerState<SellView> createState() => _SellViewState();
}

class _SellViewState extends ConsumerState<SellView> {
  final Set<int> _selectedIndexes = {};
  int _lastValidTotal = 0;
  int _timerKeySeed = 0;

  MarketState _marketState = MarketState.shopping;

  @override
  Widget build(BuildContext context) {
    final displayItemsAsync = ref.watch(displayItemsProvider('sellView'));
    final marketState = ref.watch(marketProvider).value;
    final user = ref.watch(userProvider).value;

    return Column(
      children: [
        Expanded(
          child: displayItemsAsync.when(
            data: (displayItems) {
              final currentTotal = _getTotalPrice(
                displayItems,
                marketState?.sellPrices ?? {},
              );

              if (currentTotal > 0) {
                _lastValidTotal = currentTotal;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SellView._horizontalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppDimensions.spacingMedium,
                  children: [
                    AnimatedOpacity(
                      opacity: _selectedIndexes.isNotEmpty ? 1.0 : 0.0,
                      duration: Duration(
                        milliseconds: SellView._totalPriceBannerAnimation,
                      ),
                      child: TotalPriceBanner(
                        icon: Icons.monetization_on_outlined,
                        totalPrice: _lastValidTotal,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(
                        milliseconds: SellView._marketStateChangeAnimation,
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
                      child: CircularProgressIndicator(),
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
    final user = ref.read(userProvider).value;
    final isOwned = user?.inventory.containsKey(item.id) ?? false;
    if (!isOwned) return;

    setState(() {
      if (_selectedIndexes.contains(index)) {
        _selectedIndexes.remove(index);
      } else {
        _selectedIndexes.add(index);
      }
    });
  }

  void _onCycleComplete() async {
    _marketState = ref
        .read(transactionControllerProvider)
        .executeSellCycle(_selectedIndexes);

    setState(() {
      _selectedIndexes.clear();
    });

    await Future.delayed(
      const Duration(milliseconds: SellView._successStateDuration),
    );

    if (!mounted) return;

    ref.invalidate(displayItemsProvider('sellView'));

    setState(() {
      _marketState = MarketState.shopping;
      _timerKeySeed++;
    });
  }
}
