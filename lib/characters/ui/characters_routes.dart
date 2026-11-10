import 'package:rick_and_morty/characters/domain/entities/character.dart';

abstract final class CharactersRoutes {
  static const String details = '/characters/details';
}

class CharacterDetailsArgs {
  const CharacterDetailsArgs({required this.id, this.character});

  final int id;
  final Character? character;
}
