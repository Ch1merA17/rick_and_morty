import 'package:flutter/material.dart';
import 'package:rick_and_morty/characters/ui/characters_list/characters_list_state.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';
import 'package:rick_and_morty/common/utils/plural.dart';

class CharactersHeader extends StatelessWidget {
  const CharactersHeader({
    super.key,
    required this.state,
    required this.searchField,
    required this.trailing,
  });

  final CharactersListState state;
  final Widget searchField;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    final subtitle = _subtitle();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Персонажи',
                  style: textStyles.h1.copyWith(color: colors.primaryText),
                ),
              ),
              trailing,
            ],
          ),
          const SizedBox(height: 2),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              subtitle,
              key: ValueKey(subtitle),
              style: textStyles.caption.copyWith(color: colors.secondaryText),
            ),
          ),
          const SizedBox(height: 12),
          searchField,
        ],
      ),
    );
  }

  String _subtitle() {
    switch (state.status) {
      case CharactersListStatus.loading:
        return 'Загружаем…';
      case CharactersListStatus.failure:
        return 'Вселенная Rick and Morty';
      case CharactersListStatus.success:
        final count = state.totalCount;
        final noun = plural(count, 'персонаж', 'персонажа', 'персонажей');
        if (state.query.isEmpty) return '$count $noun во вселенной';
        return '${plural(count, 'Найден', 'Найдено', 'Найдено')} $count $noun';
    }
  }
}
