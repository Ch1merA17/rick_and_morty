import 'package:flutter/material.dart';
import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/characters/ui/characters_list/views/characters_grid_layout.dart';
import 'package:rick_and_morty/characters/ui/common/character_image.dart';
import 'package:rick_and_morty/characters/ui/common/character_labels.dart';
import 'package:rick_and_morty/characters/ui/common/status_dot.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';
import 'package:rick_and_morty/components/pressable_card.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.character,
    required this.onTap,
  });

  static const BorderRadius borderRadius = BorderRadius.all(
    Radius.circular(16),
  );

  final Character character;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    return PressableCard(
      onTap: onTap,
      borderRadius: borderRadius,
      semanticLabel: '${character.name}, ${character.statusLabel}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: CharacterImage(
              character: character,
              borderRadius: BorderRadius.vertical(top: borderRadius.topLeft),
            ),
          ),
          Expanded(
            child: Padding(
              padding: CharactersGridLayout.infoPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyles.title.copyWith(color: colors.primaryText),
                  ),
                  const SizedBox(height: CharactersGridLayout.infoSpacing),
                  Row(
                    children: [
                      StatusDot(color: character.status.color(colors)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '${character.statusLabel} · ${character.species}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textStyles.caption.copyWith(
                            color: colors.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
