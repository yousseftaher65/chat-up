import 'package:flutter/material.dart';

class DotsLoadingIndicatorWidget extends StatefulWidget {
  final Color color;
  final double dotSize;

  const DotsLoadingIndicatorWidget({
    super.key,
    this.color = const Color(0xFF49AAFF),
    this.dotSize = 10.0,
  });

  @override
  State<DotsLoadingIndicatorWidget> createState() => _DotsLoadingIndicatorWidgetState();
}

class _DotsLoadingIndicatorWidgetState extends State<DotsLoadingIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            // Stagger each dot's animation by 0.2 of the cycle
            final delay = index * 0.2;
            final value = (_controller.value - delay) % 1.0;
            final opacity = _dotOpacity(value);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Opacity(
                opacity: opacity,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 1600),
                  scale: _dotSize(value),
                  child: Container(
                    width: widget.dotSize,
                    height: widget.dotSize,
                    decoration: BoxDecoration(
                      color: widget.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  double _dotOpacity(double t) {
    // Fade in then out based on where in the cycle this dot is
    if (t < 0.5) {
      return 0.3 + (t / 0.5) * 0.7; // fade 0.3 -> 1.0
    } else {
      return 1.0 - ((t - 0.5) / 0.5) * 0.7; // fade 1.0 -> 0.3
    }
  }

  double _dotSize(double t) {
    // Scale up then down based on where in the cycle this dot is
    if (t < 0.5) {
      return 1.0 + (t / 0.5) * 0.7; // scale 1.0 -> 1.3
    } else {
      return 1.3 - ((t - 0.5) / 0.5) * 0.7; // scale 1.3 -> 1.0
    }
  }
}
