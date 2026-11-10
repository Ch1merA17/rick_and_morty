import 'package:rick_and_morty/characters/domain/entities/character.dart';

abstract interface class CharactersRouter {
  Future<void> openCharacterDetails(Character character);
}
