import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/characters/domain/entities/characters_page.dart';

abstract interface class CharactersRepository {
  Future<CharactersPage> getCharacters({required int page, String name = ''});

  Future<Character> getCharacter(int id);
}
