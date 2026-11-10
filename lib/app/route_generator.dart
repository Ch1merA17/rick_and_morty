import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/app_assembly.dart';
import 'package:rick_and_morty/characters/characters_assembly.dart';
import 'package:rick_and_morty/characters/ui/characters_route_generator.dart';

abstract final class AppRoutes {
  static const String root = '/';
}

class RouteGenerator {
  RouteGenerator._(this._appAssembly, this._charactersRouteGenerator);

  factory RouteGenerator.create({required AppAssembly assembly}) =>
      RouteGenerator._(assembly, CharactersRouteGenerator(assembly));

  final AppAssembly _appAssembly;
  final CharactersRouteGenerator _charactersRouteGenerator;

  Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.root) return _rootRoute(settings);

    final route = _charactersRouteGenerator.generateRoute(settings);
    if (route != null) return route;

    debugPrint('Unknown route: ${settings.name}');
    return _rootRoute(settings);
  }

  Route<void> _rootRoute(RouteSettings settings) => MaterialPageRoute(
    settings: settings,
    builder: (_) => _appAssembly.createCharactersListPage(),
  );
}
