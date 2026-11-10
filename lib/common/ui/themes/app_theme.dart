import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty/common/ui/themes/app_colors.dart';
import 'package:rick_and_morty/common/ui/themes/app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData light() => _build(AppColors.light, Brightness.light);

  static ThemeData dark() => _build(AppColors.dark, Brightness.dark);

  static ThemeData _build(AppColors colors, Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: colors.accent,
      brightness: brightness,
      primary: colors.accent,
      onPrimary: colors.onAccent,
      surface: colors.surface,
      error: colors.error,
    );
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.background,
      splashFactory: InkSparkle.splashFactory,
      extensions: [colors, AppTextStyles.regular],
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        surfaceTintColor: Colors.transparent,
        foregroundColor: colors.primaryText,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.regular.title.copyWith(
          color: colors.primaryText,
        ),
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: colors.accent),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.accent,
        selectionHandleColor: colors.accent,
        selectionColor: colors.accent.withValues(alpha: 0.3),
      ),
    );
  }
}

extension ThemeAccessor on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;

  AppTextStyles get textStyles => Theme.of(this).extension<AppTextStyles>()!;

  SystemUiOverlayStyle get systemOverlayStyle =>
      Theme.of(this).appBarTheme.systemOverlayStyle!;
}
