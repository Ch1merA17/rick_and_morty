import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/ui/app_exception_ui.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';
import 'package:rick_and_morty/domain/errors/app_exception.dart';

class StateMessageView extends StatelessWidget {
  const StateMessageView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  factory StateMessageView.error(
    AppException error, {
    Key? key,
    required VoidCallback onRetry,
  }) => StateMessageView(
    key: key,
    icon: error.icon,
    title: error.title,
    message: error.message,
    actionLabel: 'Повторить',
    onAction: onRetry,
  );

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    final actionLabel = this.actionLabel;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _AppearingIcon(icon: icon),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: textStyles.h2.copyWith(color: colors.primaryText),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: textStyles.body.copyWith(color: colors.secondaryText),
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: onAction,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(180, 48),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    actionLabel,
                    style: textStyles.title.copyWith(color: colors.onAccent),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AppearingIcon extends StatelessWidget {
  const _AppearingIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.6, end: 1),
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.accent.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Icon(icon, size: 40, color: colors.accent),
        ),
      ),
    );
  }
}
