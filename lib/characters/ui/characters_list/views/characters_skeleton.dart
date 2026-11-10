import 'package:flutter/material.dart';
import 'package:rick_and_morty/characters/ui/characters_list/views/character_card.dart';
import 'package:rick_and_morty/characters/ui/characters_list/views/characters_grid_layout.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';
import 'package:rick_and_morty/components/shimmer.dart';

class CharactersSkeleton extends StatelessWidget {
  const CharactersSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final layout = CharactersGridLayout.of(
            context,
            constraints.maxWidth - CharactersListPadding.horizontal,
          );
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: CharactersListPadding.content,
            gridDelegate: layout.delegate,
            itemCount: layout.columns * 4,
            itemBuilder: (context, _) => const _SkeletonCard(),
          );
        },
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.stroke),
        borderRadius: CharacterCard.borderRadius,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: SkeletonBox(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: CharactersGridLayout.infoPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.75,
                    child: SkeletonBox(height: 14),
                  ),
                  SizedBox(height: 8),
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: SkeletonBox(height: 11),
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
