import 'package:flutter/material.dart';
import 'package:sell_buy_app/extensions/currency_extension.dart';

import '../../constants/app_dimensions.dart';

class TotalPriceBanner extends StatelessWidget {
  const TotalPriceBanner({
    super.key,
    required this.icon,
    required this.totalPrice,
    this.color,
  });

  final IconData icon;
  final int totalPrice;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? Theme.of(context).textTheme.bodyMedium?.color;
    return Padding(
      padding: const EdgeInsets.only(right: AppDimensions.spacingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: AppDimensions.spacingTiny,
        children: [
          Icon(icon, size: AppDimensions.iconMedium, color: effectiveColor),
          Text(totalPrice.asCurrency, style: TextStyle(color: effectiveColor)),
        ],
      ),
    );
  }
}
