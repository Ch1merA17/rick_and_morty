import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/characters/ui/character_details/views/character_info_card.dart';
import 'package:rick_and_morty/characters/ui/character_details/views/character_status_chip.dart';
import 'package:rick_and_morty/characters/ui/common/character_image.dart';
import 'package:rick_and_morty/characters/ui/common/character_labels.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';
import 'package:rick_and_morty/components/route_entrance.dart';

class CharacterDetailsContent extends StatefulWidget {
  const CharacterDetailsContent({super.key, required this.character});

  final Character character;

  @override
  State<CharacterDetailsContent> createState() =>
      _CharacterDetailsContentState();
}

class _CharacterDetailsContentState extends State<CharacterDetailsContent> {
  static const double _maxContentWidth = 560;
  static const double _horizontalPadding = 16;
  static const BorderRadius _imageRadius = BorderRadius.all(
    Radius.circular(24),
  );

  bool _isTitleVisible = false;

  bool _onScroll(ScrollUpdateNotification notification) {
    if (notification.depth != 0) return false;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final imageSize =
        math.min(screenWidth, _maxContentWidth) - _horizontalPadding * 2;
    final isTitleVisible = notification.metrics.pixels > imageSize;
    if (isTitleVisible != _isTitleVisible) {
      setState(() => _isTitleVisible = isTitleVisible);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final character = widget.character;
    final colors = context.colors;
    final textStyles = context.textStyles;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: _isTitleVisible ? colors.stroke : Colors.transparent,
          ),
        ),
        title: AnimatedOpacity(
          opacity: _isTitleVisible ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: Text(
            character.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: _onScroll,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            _horizontalPadding,
            8,
            _horizontalPadding,
            24 + bottomInset,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: _maxContentWidth - _horizontalPadding * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: CharacterImage(
                      character: character,
                      borderRadius: _imageRadius,
                    ),
                  ),
                  const SizedBox(height: 20),
                  RouteEntrance(
                    index: 0,
                    child: Text(
                      character.name,
                      style: textStyles.h1.copyWith(color: colors.primaryText),
                    ),
                  ),
                  const SizedBox(height: 10),
                  RouteEntrance(
                    index: 1,
                    child: CharacterStatusChip(character: character),
                  ),
                  const SizedBox(height: 20),
                  RouteEntrance(
                    index: 2,
                    child: CharacterInfoCard(items: _infoItems(character)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<CharacterInfoItem> _infoItems(Character character) => [
    CharacterInfoItem(
      icon: Icons.science_outlined,
      label: 'Вид',
      value: character.speciesLabel,
    ),
    CharacterInfoItem(
      icon: Icons.wc_rounded,
      label: 'Пол',
      value: character.genderLabel,
    ),
    CharacterInfoItem(
      icon: Icons.public_rounded,
      label: 'Происхождение',
      value: character.originLabel,
    ),
    CharacterInfoItem(
      icon: Icons.place_outlined,
      label: 'Текущая локация',
      value: character.locationLabel,
    ),
    CharacterInfoItem(
      icon: Icons.movie_outlined,
      label: 'Появления',
      value: character.episodesLabel,
    ),
  ];
}
