import 'package:flutter/material.dart';

class MarketStateIcon extends StatelessWidget {
  const MarketStateIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    this.iconSize = 132,
  });

  final IconData icon;
  final double iconSize;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: iconSize, color: iconColor);
  }
}
