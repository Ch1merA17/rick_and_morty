import 'package:rick_and_morty/domain/entities/theme_preference.dart';
import 'package:rick_and_morty/domain/repositories/theme_settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSettingsRepositoryImpl implements ThemeSettingsRepository {
  ThemeSettingsRepositoryImpl(this._preferences);

  static const String themePreferenceKey = 'theme_preference';

  final SharedPreferencesWithCache _preferences;

  @override
  ThemePreference get themePreference {
    final stored = _preferences.getString(themePreferenceKey);
    return ThemePreference.values.asNameMap()[stored] ?? ThemePreference.system;
  }

  @override
  Future<void> saveThemePreference(ThemePreference preference) =>
      _preferences.setString(themePreferenceKey, preference.name);
}
