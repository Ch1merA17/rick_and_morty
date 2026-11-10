import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme_cubit.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Tooltip(
      message: 'Тёмная тема',
      child: Switch(
        value: isDark,
        onChanged: (value) {
          HapticFeedback.selectionClick();
          context.read<AppThemeCubit>().setDarkMode(value);
        },
        activeTrackColor: colors.accent,
        inactiveTrackColor: colors.secondaryText.withValues(alpha: 0.25),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colors.onAccent
              : colors.surface,
        ),
        thumbIcon: WidgetStateProperty.resolveWith(
          (states) => Icon(
            states.contains(WidgetState.selected)
                ? Icons.dark_mode_rounded
                : Icons.light_mode_rounded,
            size: 16,
            color: colors.accent,
          ),
        ),
      ),
    );
  }
}
