import 'package:flutter/cupertino.dart';

class AppDimensions {
  AppDimensions._();

  static const double spacingTiny = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingLarger = 32.0;
  static const double spacingXLarge = 64.0;

  static const double radiusSmall = 8.0;
  static const double radiusMedium = 16.0;

  static const double iconSmall = 16.0;
  static const double iconMedium = 20.0;
}

class GridDimensions {
  GridDimensions._();

  static const int crossAxisCount = 2;
  static const double axisSpacing = 8;
  static const double aspectRatio = 2 / 2.8;

  static const SliverGridDelegate delegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: crossAxisCount,
  mainAxisSpacing: axisSpacing,
  crossAxisSpacing: axisSpacing,
  childAspectRatio: aspectRatio,
  );
}