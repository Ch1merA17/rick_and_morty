import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';

class CharacterImage extends StatelessWidget {
  const CharacterImage({
    super.key,
    required this.character,
    required this.borderRadius,
  });

  final Character character;
  final BorderRadius borderRadius;

  static Object heroTag(int characterId) => 'character-image-$characterId';

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag(character.id),
      flightShuttleBuilder: _flightShuttle,
      child: _RoundedNetworkImage(
        url: character.imageUrl,
        borderRadius: borderRadius,
      ),
    );
  }

  static Widget _flightShuttle(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection direction,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    final fromImage = (fromHeroContext.widget as Hero).child;
    final toImage = (toHeroContext.widget as Hero).child;
    if (fromImage is! _RoundedNetworkImage ||
        toImage is! _RoundedNetworkImage) {
      return toImage;
    }

    final (listImage, detailsImage) = direction == HeroFlightDirection.push
        ? (fromImage, toImage)
        : (toImage, fromImage);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => _RoundedNetworkImage(
        url: detailsImage.url,
        borderRadius: BorderRadius.lerp(
          listImage.borderRadius,
          detailsImage.borderRadius,
          animation.value,
        )!,
      ),
    );
  }
}

class _RoundedNetworkImage extends StatelessWidget {
  const _RoundedNetworkImage({required this.url, required this.borderRadius});

  final String url;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 250),
        placeholder: (context, _) => ColoredBox(color: colors.skeletonBase),
        errorWidget: (context, _, _) => ColoredBox(
          color: colors.skeletonBase,
          child: Icon(
            Icons.person_outline_rounded,
            size: 40,
            color: colors.secondaryText,
          ),
        ),
      ),
    );
  }
}
