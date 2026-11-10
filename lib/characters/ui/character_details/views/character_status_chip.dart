import 'package:flutter/material.dart';
import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/characters/ui/common/character_labels.dart';
import 'package:rick_and_morty/characters/ui/common/status_dot.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';

class CharacterStatusChip extends StatelessWidget {
  const CharacterStatusChip({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final color = character.status.color(context.colors);

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: color.withValues(alpha: 0.14),
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatusDot(
              color: color,
              pulse: character.status == CharacterStatus.alive,
            ),
            const SizedBox(width: 8),
            Text(
              character.statusLabel,
              style: context.textStyles.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
