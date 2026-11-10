import 'package:rick_and_morty/characters/domain/entities/character.dart';

class CharactersPage {
  const CharactersPage({
    required this.characters,
    required this.totalCount,
    required this.nextPage,
  });

  const CharactersPage.empty()
    : characters = const [],
      totalCount = 0,
      nextPage = null;

  final List<Character> characters;
  final int totalCount;
  final int? nextPage;
}
