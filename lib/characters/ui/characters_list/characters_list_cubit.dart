import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/characters/domain/characters_router.dart';
import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/characters/ui/characters_list/characters_list_state.dart';
import 'package:rick_and_morty/domain/errors/app_exception.dart';

class CharactersListCubit extends Cubit<CharactersListState> {
  CharactersListCubit(
    this._repository,
    this._router, {
    this._searchDebounce = const Duration(milliseconds: 400),
  }) : super(const CharactersListState());

  final CharactersRepository _repository;
  final CharactersRouter _router;
  final Duration _searchDebounce;

  Timer? _debounceTimer;

  int _session = 0;
  bool _isRefreshing = false;
  bool _isDetailsOpened = false;

  void init() => unawaited(_loadFirstPage(state.query));

  void onSearchChanged(String text) {
    _debounceTimer?.cancel();
    final query = text.trim();
    if (query == state.query) return;
    _debounceTimer = Timer(_searchDebounce, () => _loadFirstPage(query));
  }

  void onSearchSubmitted(String text) {
    _debounceTimer?.cancel();
    final query = text.trim();
    final isActual =
        query == state.query && state.status != CharactersListStatus.failure;
    if (isActual) return;
    unawaited(_loadFirstPage(query));
  }

  void onSearchCleared() => onSearchSubmitted('');

  void retry() => unawaited(_loadFirstPage(state.query));

  Future<void> refresh() => _loadFirstPage(state.query, isRefresh: true);

  Future<void> loadNextPage() async {
    final canLoad =
        state.status == CharactersListStatus.success &&
        state.hasMore &&
        !state.isLoadingMore &&
        state.loadMoreError == null &&
        !_isRefreshing;
    if (!canLoad) return;
    await _loadMore();
  }

  Future<void> retryLoadMore() async {
    if (!state.hasMore || state.isLoadingMore || _isRefreshing) return;
    await _loadMore();
  }

  Future<void> onCharacterTap(Character character) async {
    if (_isDetailsOpened) return;
    _isDetailsOpened = true;
    try {
      await _router.openCharacterDetails(character);
    } finally {
      _isDetailsOpened = false;
    }
  }

  Future<void> _loadFirstPage(String query, {bool isRefresh = false}) async {
    _debounceTimer?.cancel();
    final session = ++_session;
    _isRefreshing = isRefresh;
    if (!isRefresh) emit(CharactersListState(query: query));

    try {
      final page = await _repository.getCharacters(page: 1, name: query);
      if (_isOutdated(session)) return;
      emit(
        CharactersListState(
          status: CharactersListStatus.success,
          query: query,
          characters: page.characters,
          totalCount: page.totalCount,
          nextPage: page.nextPage,
        ),
      );
    } catch (error, stackTrace) {
      if (_isOutdated(session)) return;
      _onFirstPageError(query, _toAppException(error, stackTrace), isRefresh);
    } finally {
      if (session == _session) _isRefreshing = false;
    }
  }

  void _onFirstPageError(String query, AppException error, bool isRefresh) {
    if (isRefresh && state.characters.isNotEmpty) {
      emit(state.copyWith(isLoadingMore: false, refreshError: error));
      emit(state.copyWith(refreshError: null));
      return;
    }
    emit(
      CharactersListState(
        status: CharactersListStatus.failure,
        query: query,
        error: error,
      ),
    );
  }

  Future<void> _loadMore() async {
    final session = _session;
    final page = state.nextPage!;
    emit(state.copyWith(isLoadingMore: true, loadMoreError: null));

    try {
      final result = await _repository.getCharacters(
        page: page,
        name: state.query,
      );
      if (_isOutdated(session)) return;
      emit(
        state.copyWith(
          characters: _merge(state.characters, result.characters),
          totalCount: result.totalCount,
          nextPage: result.nextPage,
          isLoadingMore: false,
        ),
      );
    } catch (error, stackTrace) {
      if (_isOutdated(session)) return;
      emit(
        state.copyWith(
          isLoadingMore: false,
          loadMoreError: _toAppException(error, stackTrace),
        ),
      );
    }
  }

  bool _isOutdated(int session) => isClosed || session != _session;

  List<Character> _merge(List<Character> current, List<Character> next) {
    final ids = {for (final character in current) character.id};
    return [...current, ...next.where((character) => ids.add(character.id))];
  }

  AppException _toAppException(Object error, StackTrace stackTrace) {
    if (error is! AppException) {
      debugPrint('Characters loading failed: $error\n$stackTrace');
    }
    return AppException.from(error);
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
