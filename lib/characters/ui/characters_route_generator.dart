import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/app_assembly.dart';
import 'package:rick_and_morty/characters/characters_assembly.dart';
import 'package:rick_and_morty/characters/ui/characters_routes.dart';

class CharactersRouteGenerator {
  CharactersRouteGenerator(this._appAssembly);

  final AppAssembly _appAssembly;

  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CharactersRoutes.details:
        final args = settings.arguments! as CharacterDetailsArgs;
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => _appAssembly.createCharacterDetailsPage(args),
        );
      default:
        return null;
    }
  }
}
