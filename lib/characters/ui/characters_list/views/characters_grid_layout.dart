import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';

class CharactersGridLayout {
  const CharactersGridLayout._({
    required this.columns,
    required this.tileExtent,
  });

  factory CharactersGridLayout.of(BuildContext context, double width) {
    final columns = math.max(
      2,
      ((width + spacing) / (_minTileWidth + spacing)).floor(),
    );
    final tileWidth = (width - spacing * (columns - 1)) / columns;

    final scaler = MediaQuery.textScalerOf(context);
    final styles = context.textStyles;
    double lineHeight(TextStyle style) =>
        scaler.scale(style.fontSize!) * (style.height ?? 1.2);

    final infoHeight =
        infoPadding.vertical +
        lineHeight(styles.title) +
        infoSpacing +
        lineHeight(styles.caption) +
        _roundingReserve;

    return CharactersGridLayout._(
      columns: columns,
      tileExtent: tileWidth + infoHeight,
    );
  }

  static const double spacing = 12;
  static const EdgeInsets infoPadding = EdgeInsets.fromLTRB(12, 10, 12, 12);
  static const double infoSpacing = 4;
  static const double _minTileWidth = 160;
  static const double _roundingReserve = 4;

  final int columns;
  final double tileExtent;

  SliverGridDelegate get delegate => SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: columns,
    mainAxisExtent: tileExtent,
    crossAxisSpacing: spacing,
    mainAxisSpacing: spacing,
  );
}

abstract final class CharactersListPadding {
  static const double horizontal = 32;
  static const EdgeInsets content = EdgeInsets.fromLTRB(16, 4, 16, 16);
}
