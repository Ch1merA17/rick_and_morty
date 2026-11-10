import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/theme_preference.dart';
import 'package:rick_and_morty/domain/repositories/theme_settings_repository.dart';

class AppThemeCubit extends Cubit<ThemeMode> {
  AppThemeCubit(this._repository)
    : super(_toThemeMode(_repository.themePreference));

  final ThemeSettingsRepository _repository;

  Future<void> setDarkMode(bool isDark) async {
    final preference = isDark ? ThemePreference.dark : ThemePreference.light;
    emit(_toThemeMode(preference));
    try {
      await _repository.saveThemePreference(preference);
    } catch (error, stackTrace) {
      debugPrint('Theme preference saving failed: $error\n$stackTrace');
    }
  }

  static ThemeMode _toThemeMode(ThemePreference preference) =>
      switch (preference) {
        ThemePreference.system => ThemeMode.system,
        ThemePreference.light => ThemeMode.light,
        ThemePreference.dark => ThemeMode.dark,
      };
}
