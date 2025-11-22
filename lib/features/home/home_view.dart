import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sell_buy_app/core/user/user_provider.dart';

import '../buy/buy_view.dart';
import '../sell/sell_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: _buildAppBar(balance: user.formattedBalance),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _tabIndex == 0
            ? const BuyView(key: ValueKey('buy'))
            : const SellView(key: ValueKey('sell')),
      ),
    );
  }

  AppBar _buildAppBar({required String balance}) {
    return AppBar(
      title: ToggleButtons(
        isSelected: [_tabIndex == 0, _tabIndex == 1],
        onPressed: (index) => setState(() => _tabIndex = index),
        borderRadius: BorderRadius.circular(16),
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text('Buy'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text('Sell'),
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              Text(balance),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.question_mark_outlined, size: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
