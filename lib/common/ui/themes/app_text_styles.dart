import 'package:flutter/material.dart';

@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.h1,
    required this.h2,
    required this.title,
    required this.body,
    required this.caption,
    required this.label,
  });

  static const regular = AppTextStyles(
    h1: TextStyle(
      fontSize: 28,
      height: 1.2,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.4,
    ),
    h2: TextStyle(
      fontSize: 20,
      height: 1.25,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
    ),
    title: TextStyle(fontSize: 16, height: 1.25, fontWeight: FontWeight.w600),
    body: TextStyle(fontSize: 15, height: 1.35, fontWeight: FontWeight.w400),
    caption: TextStyle(fontSize: 13, height: 1.3, fontWeight: FontWeight.w500),
    label: TextStyle(
      fontSize: 11,
      height: 1.3,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
    ),
  );

  final TextStyle h1;
  final TextStyle h2;
  final TextStyle title;
  final TextStyle body;
  final TextStyle caption;
  final TextStyle label;

  @override
  AppTextStyles copyWith({
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? title,
    TextStyle? body,
    TextStyle? caption,
    TextStyle? label,
  }) => AppTextStyles(
    h1: h1 ?? this.h1,
    h2: h2 ?? this.h2,
    title: title ?? this.title,
    body: body ?? this.body,
    caption: caption ?? this.caption,
    label: label ?? this.label,
  );

  @override
  AppTextStyles lerp(AppTextStyles? other, double t) {
    if (other == null) return this;
    TextStyle mix(TextStyle a, TextStyle b) => TextStyle.lerp(a, b, t)!;
    return AppTextStyles(
      h1: mix(h1, other.h1),
      h2: mix(h2, other.h2),
      title: mix(title, other.title),
      body: mix(body, other.body),
      caption: mix(caption, other.caption),
      label: mix(label, other.label),
    );
  }
}
