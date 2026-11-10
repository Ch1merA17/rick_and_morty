import 'package:http/http.dart' as http;
import 'package:rick_and_morty/characters/data/mappers/character_json_mapper.dart';
import 'package:rick_and_morty/characters/data/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme_cubit.dart';
import 'package:rick_and_morty/data/settings/theme_settings_repository_impl.dart';
import 'package:rick_and_morty/data/web/api_client.dart';
import 'package:rick_and_morty/domain/repositories/theme_settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppAssembly {
  static final Uri _apiBaseUri = Uri.parse('https://rickandmortyapi.com/api/');

  late final SharedPreferencesWithCache _preferences;

  late final http.Client _httpClient = http.Client();

  late final ApiClient _apiClient = ApiClient(
    _httpClient,
    baseUri: _apiBaseUri,
  );

  late final CharactersRepository charactersRepository =
      CharactersRepositoryImpl(_apiClient, const CharacterJsonMapper());

  late final ThemeSettingsRepository themeSettingsRepository =
      ThemeSettingsRepositoryImpl(_preferences);

  Future<void> init() async {
    _preferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: {ThemeSettingsRepositoryImpl.themePreferenceKey},
      ),
    );
  }

  AppThemeCubit createAppThemeCubit() => AppThemeCubit(themeSettingsRepository);
}
