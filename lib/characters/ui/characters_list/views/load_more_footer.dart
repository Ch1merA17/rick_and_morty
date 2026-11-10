import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/ui/app_exception_ui.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';
import 'package:rick_and_morty/domain/errors/app_exception.dart';

class LoadMoreFooter extends StatelessWidget {
  const LoadMoreFooter({
    super.key,
    required this.hasMore,
    required this.error,
    required this.onRetry,
  });

  final bool hasMore;
  final AppException? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _content(context),
      ),
    );
  }

  Widget _content(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    final error = this.error;

    if (error != null) {
      return Column(
        key: const ValueKey('error'),
        children: [
          Text(
            error.title,
            textAlign: TextAlign.center,
            style: textStyles.body.copyWith(color: colors.secondaryText),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: onRetry,
            icon: Icon(Icons.refresh_rounded, color: colors.accent),
            label: Text(
              'Повторить',
              style: textStyles.title.copyWith(color: colors.accent),
            ),
          ),
        ],
      );
    }

    if (hasMore) {
      return const SizedBox(
        key: ValueKey('loading'),
        height: 28,
        child: Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    return Text(
      'Это все персонажи',
      key: const ValueKey('end'),
      textAlign: TextAlign.center,
      style: textStyles.caption.copyWith(color: colors.secondaryText),
    );
  }
}
