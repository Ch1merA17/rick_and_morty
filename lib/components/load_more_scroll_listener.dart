import 'package:flutter/widgets.dart';

class LoadMoreScrollListener extends StatelessWidget {
  const LoadMoreScrollListener({
    super.key,
    required this.onLoadMore,
    required this.child,
    this.threshold = 600,
  });

  final VoidCallback onLoadMore;
  final Widget child;
  final double threshold;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        if (notification.depth == 0) _check(notification.metrics);
        return false;
      },
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          if (notification.depth == 0) _check(notification.metrics);
          return false;
        },
        child: child,
      ),
    );
  }

  void _check(ScrollMetrics metrics) {
    if (metrics.axis != Axis.vertical) return;
    if (metrics.extentAfter < threshold) onLoadMore();
  }
}
