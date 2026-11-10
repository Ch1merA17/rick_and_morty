import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/characters/ui/character_details/character_details_state.dart';
import 'package:rick_and_morty/domain/errors/app_exception.dart';

class CharacterDetailsCubit extends Cubit<CharacterDetailsState> {
  CharacterDetailsCubit(
    this._repository,
    this._characterId, {
    Character? initial,
  }) : super(
         initial == null
             ? const CharacterDetailsLoading()
             : CharacterDetailsLoaded(initial),
       );

  final CharactersRepository _repository;
  final int _characterId;

  void init() {
    if (state is CharacterDetailsLoaded) return;
    _load();
  }

  void retry() => _load();

  Future<void> _load() async {
    emit(const CharacterDetailsLoading());
    try {
      final character = await _repository.getCharacter(_characterId);
      if (isClosed) return;
      emit(CharacterDetailsLoaded(character));
    } catch (error, stackTrace) {
      if (isClosed) return;
      if (error is! AppException) {
        debugPrint(
          'Character $_characterId loading failed: $error\n$stackTrace',
        );
      }
      emit(CharacterDetailsFailure(AppException.from(error)));
    }
  }
}
