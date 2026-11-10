import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.stroke,
    required this.primaryText,
    required this.secondaryText,
    required this.accent,
    required this.onAccent,
    required this.statusAlive,
    required this.statusDead,
    required this.statusUnknown,
    required this.skeletonBase,
    required this.skeletonHighlight,
    required this.error,
  });

  static const light = AppColors(
    background: Color(0xFFF3F6F2),
    surface: Color(0xFFFFFFFF),
    stroke: Color(0xFFE1E7E0),
    primaryText: Color(0xFF17201A),
    secondaryText: Color(0xFF65706A),
    accent: Color(0xFF2F9E44),
    onAccent: Color(0xFFFFFFFF),
    statusAlive: Color(0xFF2FB344),
    statusDead: Color(0xFFE5484D),
    statusUnknown: Color(0xFF9AA19C),
    skeletonBase: Color(0xFFE4E9E3),
    skeletonHighlight: Color(0xFFF5F8F4),
    error: Color(0xFFD93A3F),
  );

  static const dark = AppColors(
    background: Color(0xFF0E1311),
    surface: Color(0xFF18201C),
    stroke: Color(0xFF26302B),
    primaryText: Color(0xFFEDF3EE),
    secondaryText: Color(0xFF94A099),
    accent: Color(0xFF97CE4C),
    onAccent: Color(0xFF0E1311),
    statusAlive: Color(0xFF55D06A),
    statusDead: Color(0xFFFF6369),
    statusUnknown: Color(0xFF7D8781),
    skeletonBase: Color(0xFF1E2722),
    skeletonHighlight: Color(0xFF2A352F),
    error: Color(0xFFFF6369),
  );

  final Color background;
  final Color surface;
  final Color stroke;
  final Color primaryText;
  final Color secondaryText;
  final Color accent;
  final Color onAccent;
  final Color statusAlive;
  final Color statusDead;
  final Color statusUnknown;
  final Color skeletonBase;
  final Color skeletonHighlight;
  final Color error;

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? stroke,
    Color? primaryText,
    Color? secondaryText,
    Color? accent,
    Color? onAccent,
    Color? statusAlive,
    Color? statusDead,
    Color? statusUnknown,
    Color? skeletonBase,
    Color? skeletonHighlight,
    Color? error,
  }) => AppColors(
    background: background ?? this.background,
    surface: surface ?? this.surface,
    stroke: stroke ?? this.stroke,
    primaryText: primaryText ?? this.primaryText,
    secondaryText: secondaryText ?? this.secondaryText,
    accent: accent ?? this.accent,
    onAccent: onAccent ?? this.onAccent,
    statusAlive: statusAlive ?? this.statusAlive,
    statusDead: statusDead ?? this.statusDead,
    statusUnknown: statusUnknown ?? this.statusUnknown,
    skeletonBase: skeletonBase ?? this.skeletonBase,
    skeletonHighlight: skeletonHighlight ?? this.skeletonHighlight,
    error: error ?? this.error,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      background: mix(background, other.background),
      surface: mix(surface, other.surface),
      stroke: mix(stroke, other.stroke),
      primaryText: mix(primaryText, other.primaryText),
      secondaryText: mix(secondaryText, other.secondaryText),
      accent: mix(accent, other.accent),
      onAccent: mix(onAccent, other.onAccent),
      statusAlive: mix(statusAlive, other.statusAlive),
      statusDead: mix(statusDead, other.statusDead),
      statusUnknown: mix(statusUnknown, other.statusUnknown),
      skeletonBase: mix(skeletonBase, other.skeletonBase),
      skeletonHighlight: mix(skeletonHighlight, other.skeletonHighlight),
      error: mix(error, other.error),
    );
  }
}
