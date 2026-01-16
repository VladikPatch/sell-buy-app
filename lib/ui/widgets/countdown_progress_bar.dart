import 'package:flutter/material.dart';
import 'package:sell_buy_app/constants/app_dimensions.dart';

class CountdownProgressBar extends StatefulWidget {
  static const double _barWidth = 160.0;
  static const double _barHeight = 8.0;

  const CountdownProgressBar({
    super.key,
    this.duration = const Duration(milliseconds: 4000),
    required this.onFinished,
  });

  final Duration duration;
  final VoidCallback onFinished;

  @override
  State<CountdownProgressBar> createState() => _CountdownProgressBarState();
}

class _CountdownProgressBarState extends State<CountdownProgressBar> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: widget.duration,
      onEnd: widget.onFinished,
      builder: (context, value, _) {
        return SizedBox(
          width: CountdownProgressBar._barWidth,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.black12,
              minHeight: CountdownProgressBar._barHeight,
            ),
          ),
        );
      },
    );
  }
}
