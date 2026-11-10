import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/domain/errors/app_exception.dart';

enum CharactersListStatus { loading, success, failure }

class CharactersListState {
  const CharactersListState({
    this.status = CharactersListStatus.loading,
    this.query = '',
    this.characters = const [],
    this.totalCount = 0,
    this.nextPage,
    this.error,
    this.isLoadingMore = false,
    this.loadMoreError,
    this.refreshError,
  });

  final CharactersListStatus status;
  final String query;
  final List<Character> characters;
  final int totalCount;
  final int? nextPage;
  final AppException? error;
  final bool isLoadingMore;
  final AppException? loadMoreError;
  final AppException? refreshError;

  bool get hasMore => nextPage != null;

  bool get isEmpty =>
      status == CharactersListStatus.success && characters.isEmpty;

  static const Object _keep = Object();

  CharactersListState copyWith({
    List<Character>? characters,
    int? totalCount,
    Object? nextPage = _keep,
    bool? isLoadingMore,
    Object? loadMoreError = _keep,
    Object? refreshError = _keep,
  }) => CharactersListState(
    status: status,
    query: query,
    characters: characters ?? this.characters,
    totalCount: totalCount ?? this.totalCount,
    nextPage: identical(nextPage, _keep) ? this.nextPage : nextPage as int?,
    error: error,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    loadMoreError: identical(loadMoreError, _keep)
        ? this.loadMoreError
        : loadMoreError as AppException?,
    refreshError: identical(refreshError, _keep)
        ? this.refreshError
        : refreshError as AppException?,
  );
}
