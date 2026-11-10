import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/app_assembly.dart';
import 'package:rick_and_morty/app/app_router.dart';
import 'package:rick_and_morty/characters/domain/characters_router.dart';
import 'package:rick_and_morty/characters/ui/character_details/character_details_cubit.dart';
import 'package:rick_and_morty/characters/ui/character_details/character_details_page.dart';
import 'package:rick_and_morty/characters/ui/characters_list/characters_list_cubit.dart';
import 'package:rick_and_morty/characters/ui/characters_list/characters_list_page.dart';
import 'package:rick_and_morty/characters/ui/characters_router.dart';
import 'package:rick_and_morty/characters/ui/characters_routes.dart';

extension CharactersAssembly on AppAssembly {
  Widget createCharactersListPage() => BlocProvider(
    create: (context) => CharactersListCubit(
      charactersRepository,
      createCharactersRouter(context),
    )..init(),
    child: const CharactersListPage(),
  );

  Widget createCharacterDetailsPage(CharacterDetailsArgs args) => BlocProvider(
    create: (context) => CharacterDetailsCubit(
      charactersRepository,
      args.id,
      initial: args.character,
    )..init(),
    child: const CharacterDetailsPage(),
  );

  CharactersRouter createCharactersRouter(BuildContext context) =>
      CharactersRouterImpl(AppRouter.of(context));
}
