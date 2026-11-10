import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';

class CharactersSearchField extends StatelessWidget {
  const CharactersSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: colors.stroke),
    );

    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      textInputAction: TextInputAction.search,
      autocorrect: false,
      enableSuggestions: false,
      style: textStyles.body.copyWith(color: colors.primaryText),
      decoration: InputDecoration(
        hintText: 'Поиск по имени',
        hintStyle: textStyles.body.copyWith(color: colors.secondaryText),
        filled: true,
        fillColor: colors.surface,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        prefixIcon: Icon(Icons.search_rounded, color: colors.secondaryText),
        suffixIcon: _ClearButton(controller: controller, onClear: onClear),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colors.accent, width: 1.5),
        ),
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({required this.controller, required this.onClear});

  final TextEditingController controller;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final isVisible = value.text.isNotEmpty;
        return AnimatedScale(
          scale: isVisible ? 1 : 0,
          duration: const Duration(milliseconds: 180),
          curve: isVisible ? Curves.easeOutBack : Curves.easeIn,
          child: IconButton(
            tooltip: 'Очистить',
            onPressed: isVisible
                ? () {
                    HapticFeedback.lightImpact();
                    onClear();
                  }
                : null,
            icon: Icon(
              Icons.cancel_rounded,
              color: context.colors.secondaryText,
            ),
          ),
        );
      },
    );
  }
}
