import 'package:flutter/painting.dart';
import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/common/ui/themes/app_colors.dart';
import 'package:rick_and_morty/common/utils/plural.dart';

extension CharacterLabels on Character {
  String get statusLabel {
    final isFemale = gender == CharacterGender.female;
    return switch (status) {
      CharacterStatus.alive => isFemale ? 'Жива' : 'Жив',
      CharacterStatus.dead => isFemale ? 'Мертва' : 'Мёртв',
      CharacterStatus.unknown => 'Неизвестно',
    };
  }

  String get genderLabel => switch (gender) {
    CharacterGender.female => 'Женский',
    CharacterGender.male => 'Мужской',
    CharacterGender.genderless => 'Бесполый',
    CharacterGender.unknown => 'Неизвестно',
  };

  String get speciesLabel => type.isEmpty ? species : '$species · $type';

  String get originLabel => originName.isEmpty ? 'Неизвестно' : originName;

  String get locationLabel =>
      locationName.isEmpty ? 'Неизвестно' : locationName;

  String get episodesLabel =>
      '$episodeCount ${plural(episodeCount, 'эпизод', 'эпизода', 'эпизодов')}';
}

extension CharacterStatusColor on CharacterStatus {
  Color color(AppColors colors) => switch (this) {
    CharacterStatus.alive => colors.statusAlive,
    CharacterStatus.dead => colors.statusDead,
    CharacterStatus.unknown => colors.statusUnknown,
  };
}
