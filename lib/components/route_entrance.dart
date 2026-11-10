import 'package:flutter/widgets.dart';

class RouteEntrance extends StatelessWidget {
  const RouteEntrance({
    super.key,
    required this.index,
    required this.child,
    this.start = 0.35,
    this.step = 0.08,
  });

  final int index;
  final Widget child;
  final double start;
  final double step;

  @override
  Widget build(BuildContext context) {
    final routeAnimation = ModalRoute.of(context)?.animation;
    if (routeAnimation == null) return child;

    final begin = (start + index * step).clamp(0.0, 0.8);
    final end = (begin + 0.45).clamp(0.0, 1.0);
    final animation = routeAnimation.drive(
      CurveTween(curve: Interval(begin, end, curve: Curves.easeOutCubic)),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: animation.drive(
          Tween(begin: const Offset(0, 0.12), end: Offset.zero),
        ),
        child: child,
      ),
    );
  }
}
