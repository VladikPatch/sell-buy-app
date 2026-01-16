import 'package:flutter/material.dart';
import 'package:sell_buy_app/constants/app_dimensions.dart';
import 'package:sell_buy_app/constants/enums.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SharedAppBar({
    super.key,
    required this.currentTab,
    required this.balance,
    required this.onTabChanged,
  });

  final HomeTab currentTab;
  final String balance;
  final ValueChanged<HomeTab> onTabChanged;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isInventory = currentTab == HomeTab.inventory;
    Widget titleWidget;

    if (isInventory) {
      titleWidget = IconButton(
        onPressed: () => onTabChanged(HomeTab.buy),
        icon: Icon(Icons.arrow_back_ios_new_rounded),
      );
    } else {
      titleWidget = ToggleButtons(
        isSelected: [currentTab == HomeTab.buy, currentTab == HomeTab.sell],
        onPressed: (index) {
          final newTab = HomeTab.values[index];
          onTabChanged(newTab);
        },
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingLarge,
            ),
            child: Text('Buy'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingLarge,
            ),
            child: Text('Sell'),
          ),
        ],
      );
    }

    return AppBar(
      title: titleWidget,
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppDimensions.spacingMedium),
          child: Row(
            children: [
              Text(balance),
              const SizedBox(width: AppDimensions.spacingSmall),
              IconButton(
                onPressed: () => onTabChanged(HomeTab.inventory),
                icon: Icon(
                  Icons.inventory_2_outlined,
                  size: AppDimensions.iconSmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
