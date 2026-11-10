import 'package:rick_and_morty/domain/entities/theme_preference.dart';

abstract interface class ThemeSettingsRepository {
  ThemePreference get themePreference;

  Future<void> saveThemePreference(ThemePreference preference);
}
