import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/characters/ui/characters_list/characters_list_cubit.dart';
import 'package:rick_and_morty/characters/ui/characters_list/characters_list_state.dart';
import 'package:rick_and_morty/characters/ui/characters_list/views/characters_grid.dart';
import 'package:rick_and_morty/characters/ui/characters_list/views/characters_header.dart';
import 'package:rick_and_morty/characters/ui/characters_list/views/characters_search_field.dart';
import 'package:rick_and_morty/characters/ui/characters_list/views/characters_skeleton.dart';
import 'package:rick_and_morty/common/ui/app_exception_ui.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';
import 'package:rick_and_morty/common/ui/themes/theme_switch.dart';
import 'package:rick_and_morty/components/state_message_view.dart';

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({super.key});

  @override
  State<CharactersListPage> createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  final _searchController = TextEditingController();

  CharactersListCubit get _cubit => context.read<CharactersListCubit>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    _cubit.onSearchCleared();
  }

  void _openCharacter(Character character) {
    FocusScope.of(context).unfocus();
    _cubit.onCharacterTap(character);
  }

  void _showRefreshError(BuildContext context, CharactersListState state) {
    final colors = context.colors;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            state.refreshError!.title,
            style: context.textStyles.body.copyWith(color: colors.surface),
          ),
          backgroundColor: colors.primaryText,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.systemOverlayStyle,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: BlocConsumer<CharactersListCubit, CharactersListState>(
            listenWhen: (previous, current) =>
                current.refreshError != null &&
                previous.refreshError != current.refreshError,
            listener: _showRefreshError,
            builder: (context, state) => Column(
              children: [
                CharactersHeader(
                  state: state,
                  searchField: CharactersSearchField(
                    controller: _searchController,
                    onChanged: _cubit.onSearchChanged,
                    onSubmitted: _cubit.onSearchSubmitted,
                    onClear: _clearSearch,
                  ),
                  trailing: const ThemeSwitch(),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    child: _buildBody(state),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(CharactersListState state) {
    switch (state.status) {
      case CharactersListStatus.loading:
        return const CharactersSkeleton(key: ValueKey('loading'));
      case CharactersListStatus.failure:
        return StateMessageView.error(
          state.error!,
          key: const ValueKey('failure'),
          onRetry: _cubit.retry,
        );
      case CharactersListStatus.success when state.isEmpty:
        return StateMessageView(
          key: const ValueKey('empty'),
          icon: Icons.person_search_rounded,
          title: 'Никого не нашли',
          message: state.query.isEmpty
              ? 'Список персонажей пуст.'
              : 'По запросу «${state.query}» персонажей нет. '
                    'Попробуйте другое имя.',
          actionLabel: state.query.isEmpty ? null : 'Сбросить поиск',
          onAction: state.query.isEmpty ? null : _clearSearch,
        );
      case CharactersListStatus.success:
        return CharactersGrid(
          key: ValueKey('content-${state.query}'),
          state: state,
          onCharacterTap: _openCharacter,
          onLoadMore: _cubit.loadNextPage,
          onRetryLoadMore: _cubit.retryLoadMore,
          onRefresh: _cubit.refresh,
        );
    }
  }
}
