import 'package:rick_and_morty/app/app_router.dart';
import 'package:rick_and_morty/characters/domain/characters_router.dart';
import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/characters/ui/characters_routes.dart';

class CharactersRouterImpl implements CharactersRouter {
  CharactersRouterImpl(this._router);

  final AppRouter _router;

  @override
  Future<void> openCharacterDetails(Character character) => _router.push<void>(
    CharactersRoutes.details,
    arguments: CharacterDetailsArgs(id: character.id, character: character),
  );
}
