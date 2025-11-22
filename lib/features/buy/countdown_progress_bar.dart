import 'package:flutter/material.dart';

class CountdownProgressBar extends StatefulWidget {
  const CountdownProgressBar({
    super.key,
    this.duration = const Duration(seconds: 20),
    required this.onCycleComplete,
    this.height = 40,
    this.borderRadius = 16,
  });

  final Duration duration;
  final VoidCallback onCycleComplete;
  final double height;
  final double borderRadius;

  @override
  State<CountdownProgressBar> createState() => _CountdownProgressBarState();
}

class _CountdownProgressBarState extends State<CountdownProgressBar> {
  int cycleSeed = 0;

  void _restart() {
    setState(() {
      cycleSeed++;
    });
    widget.onCycleComplete();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(cycleSeed),
      tween: Tween(begin: 1.0, end: 0.0),
      duration: widget.duration,
      onEnd: _restart,
      builder: (context, value, _) {
        return SizedBox(
          width: 160,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value,
              minHeight: widget.height,
              backgroundColor: Colors.black12,
            ),
          ),
        );
      },
    );
  }
}
