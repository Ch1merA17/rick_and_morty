import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';

class PressableCard extends StatefulWidget {
  const PressableCard({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.pressedScale = 0.96,
    this.semanticLabel,
  });

  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;
  final double pressedScale;
  final String? semanticLabel;

  @override
  State<PressableCard> createState() => _PressableCardState();
}

class _PressableCardState extends State<PressableCard> {
  bool _isPressed = false;

  void _onHighlightChanged(bool isPressed) {
    if (_isPressed == isPressed) return;
    setState(() => _isPressed = isPressed);
  }

  void _onTap() {
    HapticFeedback.selectionClick();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final shape = RoundedRectangleBorder(
      borderRadius: widget.borderRadius,
      side: BorderSide(color: colors.stroke),
    );

    return Semantics(
      container: true,
      button: widget.onTap != null,
      label: widget.semanticLabel,
      excludeSemantics: widget.semanticLabel != null,
      onTap: widget.onTap == null ? null : _onTap,
      child: AnimatedScale(
        scale: _isPressed ? widget.pressedScale : 1,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        child: Material(
          color: colors.surface,
          shape: shape,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              widget.child,
              Positioned.fill(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: widget.onTap == null ? null : _onTap,
                    onHighlightChanged: _onHighlightChanged,
                    excludeFromSemantics: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
