import 'package:rick_and_morty/characters/data/mappers/character_json_mapper.dart';
import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/characters/domain/entities/characters_page.dart';
import 'package:rick_and_morty/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/data/web/api_client.dart';
import 'package:rick_and_morty/domain/errors/app_exception.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  CharactersRepositoryImpl(this._apiClient, this._mapper);

  final ApiClient _apiClient;
  final CharacterJsonMapper _mapper;

  @override
  Future<CharactersPage> getCharacters({
    required int page,
    String name = '',
  }) async {
    final query = name.trim();
    try {
      final json = await _apiClient.getJson(
        'character',
        queryParameters: {'page': '$page', if (query.isNotEmpty) 'name': query},
      );
      return _parse(() => _mapper.mapPage(json));
    } on NotFoundException {
      return const CharactersPage.empty();
    }
  }

  @override
  Future<Character> getCharacter(int id) async {
    final json = await _apiClient.getJson('character/$id');
    return _parse(() => _mapper.mapCharacter(json));
  }

  T _parse<T>(T Function() mapping) {
    try {
      return mapping();
    } on FormatException {
      throw const ServerException();
    }
  }
}
