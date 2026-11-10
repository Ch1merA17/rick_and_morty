import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/characters/domain/entities/characters_page.dart';

class CharacterJsonMapper {
  const CharacterJsonMapper();

  CharactersPage mapPage(Map<String, dynamic> json) {
    final info = _read<Map<String, dynamic>>(json, 'info');
    final results = _read<List<dynamic>>(json, 'results');

    return CharactersPage(
      characters: results
          .map((item) => mapCharacter(_cast<Map<String, dynamic>>(item)))
          .toList(growable: false),
      totalCount: _read<int>(info, 'count'),
      nextPage: _pageFromUrl(info['next']),
    );
  }

  Character mapCharacter(Map<String, dynamic> json) {
    return Character(
      id: _read<int>(json, 'id'),
      name: _read<String>(json, 'name'),
      status: _mapStatus(json['status']),
      species: _read<String>(json, 'species'),
      type: _optionalString(json['type']),
      gender: _mapGender(json['gender']),
      originName: _placeName(json['origin']),
      locationName: _placeName(json['location']),
      imageUrl: _read<String>(json, 'image'),
      episodeCount: switch (json['episode']) {
        final List<dynamic> episodes => episodes.length,
        _ => 0,
      },
    );
  }

  CharacterStatus _mapStatus(Object? value) =>
      switch (value?.toString().toLowerCase()) {
        'alive' => CharacterStatus.alive,
        'dead' => CharacterStatus.dead,
        _ => CharacterStatus.unknown,
      };

  CharacterGender _mapGender(Object? value) =>
      switch (value?.toString().toLowerCase()) {
        'female' => CharacterGender.female,
        'male' => CharacterGender.male,
        'genderless' => CharacterGender.genderless,
        _ => CharacterGender.unknown,
      };

  String _placeName(Object? value) {
    if (value is! Map<String, dynamic>) return '';
    final name = _optionalString(value['name']);
    return name.toLowerCase() == 'unknown' ? '' : name;
  }

  int? _pageFromUrl(Object? url) {
    if (url is! String || url.isEmpty) return null;
    final page = Uri.tryParse(url)?.queryParameters['page'];
    return page == null ? null : int.tryParse(page);
  }

  String _optionalString(Object? value) => value is String ? value : '';

  T _read<T>(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is T) return value;
    throw FormatException('Field "$key" is not ${T.toString()}: $value');
  }

  T _cast<T>(Object? value) {
    if (value is T) return value;
    throw FormatException('Expected ${T.toString()}, got $value');
  }
}
