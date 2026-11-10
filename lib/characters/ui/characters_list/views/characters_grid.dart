import 'package:flutter/material.dart';
import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/characters/ui/characters_list/characters_list_state.dart';
import 'package:rick_and_morty/characters/ui/characters_list/views/character_card.dart';
import 'package:rick_and_morty/characters/ui/characters_list/views/characters_grid_layout.dart';
import 'package:rick_and_morty/characters/ui/characters_list/views/load_more_footer.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';
import 'package:rick_and_morty/components/load_more_scroll_listener.dart';

class CharactersGrid extends StatelessWidget {
  const CharactersGrid({
    super.key,
    required this.state,
    required this.onCharacterTap,
    required this.onLoadMore,
    required this.onRetryLoadMore,
    required this.onRefresh,
  });

  final CharactersListState state;
  final ValueChanged<Character> onCharacterTap;
  final VoidCallback onLoadMore;
  final VoidCallback onRetryLoadMore;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final characters = state.characters;
    final colors = context.colors;

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: colors.accent,
      backgroundColor: colors.surface,
      child: LoadMoreScrollListener(
        onLoadMore: onLoadMore,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverPadding(
              padding: CharactersListPadding.content.copyWith(bottom: 0),
              sliver: SliverLayoutBuilder(
                builder: (context, constraints) {
                  final layout = CharactersGridLayout.of(
                    context,
                    constraints.crossAxisExtent,
                  );
                  return SliverGrid.builder(
                    gridDelegate: layout.delegate,
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      final character = characters[index];
                      return CharacterCard(
                        key: ValueKey(character.id),
                        character: character,
                        onTap: () => onCharacterTap(character),
                      );
                    },
                  );
                },
              ),
            ),
            SliverSafeArea(
              top: false,
              sliver: SliverToBoxAdapter(
                child: LoadMoreFooter(
                  hasMore: state.hasMore,
                  error: state.loadMoreError,
                  onRetry: onRetryLoadMore,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
