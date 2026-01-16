import 'package:flutter/material.dart';
import 'package:sell_buy_app/constants/app_dimensions.dart';

class DisplayCard extends StatelessWidget {
  const DisplayCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.imageSize = 96.0,
    this.isSelected = false,
    this.isOwned = false,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final double imageSize;
  final bool isSelected;
  final bool isOwned;
  final VoidCallback? onTap;

  static const double cardElevation = 3;
  static const double cardBorderWidth = 2;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        side: const BorderSide(color: Colors.black45, width: cardBorderWidth),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.spacingSmall,
                AppDimensions.spacingSmall,
                AppDimensions.spacingSmall,
                AppDimensions.spacingLarge,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(iconPath, width: imageSize),
                  const SizedBox(height: AppDimensions.spacingMedium),
                  Text(title),
                  Text(subtitle),
                ],
              ),
            ),

            if (isSelected)
              const Positioned(
                top: AppDimensions.spacingSmall,
                right: AppDimensions.spacingSmall,
                child: Icon(Icons.check_circle, size: AppDimensions.iconMedium),
              )
            else if (isOwned)
              const Positioned(
                top: AppDimensions.spacingSmall,
                right: AppDimensions.spacingSmall,
                child: Icon(
                  Icons.sell_outlined,
                  size: AppDimensions.iconMedium,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
