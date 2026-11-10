import 'package:flutter/material.dart';
import 'package:rick_and_morty/domain/errors/app_exception.dart';

extension AppExceptionUi on AppException {
  String get title => switch (this) {
    NoInternetException() => 'Нет подключения',
    RequestTimeoutException() => 'Сервер не отвечает',
    NotFoundException() => 'Не найдено',
    ServerException() => 'Сервер недоступен',
    UnexpectedException() => 'Что-то пошло не так',
  };

  String get message => switch (this) {
    NoInternetException() =>
      'Проверьте интернет-соединение и попробуйте ещё раз.',
    RequestTimeoutException() =>
      'Похоже, соединение слишком медленное. Попробуйте ещё раз.',
    NotFoundException() => 'Запрошенные данные не существуют.',
    ServerException() => 'Сервис временно не работает. Попробуйте позже.',
    UnexpectedException() => 'Не удалось загрузить данные. Попробуйте ещё раз.',
  };

  IconData get icon => switch (this) {
    NoInternetException() => Icons.wifi_off_rounded,
    RequestTimeoutException() => Icons.hourglass_empty_rounded,
    NotFoundException() => Icons.search_off_rounded,
    ServerException() => Icons.cloud_off_rounded,
    UnexpectedException() => Icons.error_outline_rounded,
  };
}
