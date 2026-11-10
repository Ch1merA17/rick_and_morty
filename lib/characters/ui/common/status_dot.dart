import 'package:flutter/material.dart';

class StatusDot extends StatefulWidget {
  const StatusDot({
    super.key,
    required this.color,
    this.size = 8,
    this.pulse = false,
  });

  final Color color;
  final double size;
  final bool pulse;

  @override
  State<StatusDot> createState() => _StatusDotState();
}

class _StatusDotState extends State<StatusDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  @override
  void initState() {
    super.initState();
    _syncAnimation();
  }

  @override
  void didUpdateWidget(StatusDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pulse != widget.pulse) _syncAnimation();
  }

  void _syncAnimation() {
    if (widget.pulse) {
      _controller.repeat();
    } else {
      _controller
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dot = DecoratedBox(
      decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      child: SizedBox.square(dimension: widget.size),
    );
    if (!widget.pulse) return dot;

    return SizedBox.square(
      dimension: widget.size,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = Curves.easeOut.transform(_controller.value);
              return Transform.scale(
                scale: 1 + t * 1.6,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.45 * (1 - t)),
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox.square(dimension: widget.size),
                ),
              );
            },
          ),
          dot,
        ],
      ),
    );
  }
}
