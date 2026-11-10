import 'package:rick_and_morty/characters/domain/entities/character.dart';
import 'package:rick_and_morty/domain/errors/app_exception.dart';

sealed class CharacterDetailsState {
  const CharacterDetailsState();
}

final class CharacterDetailsLoading extends CharacterDetailsState {
  const CharacterDetailsLoading();
}

final class CharacterDetailsLoaded extends CharacterDetailsState {
  const CharacterDetailsLoaded(this.character);

  final Character character;
}

final class CharacterDetailsFailure extends CharacterDetailsState {
  const CharacterDetailsFailure(this.error);

  final AppException error;
}
