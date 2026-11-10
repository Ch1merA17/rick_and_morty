import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';

class CharacterInfoItem {
  const CharacterInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}

class CharacterInfoCard extends StatelessWidget {
  const CharacterInfoCard({super.key, required this.items});

  final List<CharacterInfoItem> items;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.stroke),
      ),
      child: Column(
        children: [
          for (final (index, item) in items.indexed) ...[
            if (index > 0) Divider(height: 1, indent: 64, color: colors.stroke),
            _InfoRow(item: item),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.item});

  final CharacterInfoItem item;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(item.icon, size: 20, color: colors.accent),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label.toUpperCase(),
                  style: textStyles.label.copyWith(color: colors.secondaryText),
                ),
                const SizedBox(height: 2),
                Text(
                  item.value,
                  style: textStyles.title.copyWith(color: colors.primaryText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
