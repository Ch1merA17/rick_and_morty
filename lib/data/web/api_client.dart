import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/domain/errors/app_exception.dart';

class ApiClient {
  ApiClient(
    this._client, {
    required this._baseUri,
    this._timeout = const Duration(seconds: 15),
  });

  final http.Client _client;
  final Uri _baseUri;
  final Duration _timeout;

  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, String> queryParameters = const {},
  }) async {
    final uri = _baseUri
        .resolve(path)
        .replace(
          queryParameters: queryParameters.isEmpty ? null : queryParameters,
        );

    final http.Response response;
    try {
      response = await _client
          .get(uri, headers: const {'Accept': 'application/json'})
          .timeout(_timeout);
    } on TimeoutException {
      throw const RequestTimeoutException();
    } on SocketException {
      throw const NoInternetException();
    } on http.ClientException {
      throw const NoInternetException();
    }

    return _decode(response);
  }

  Map<String, dynamic> _decode(http.Response response) {
    final statusCode = response.statusCode;
    if (statusCode == HttpStatus.notFound) {
      throw const NotFoundException();
    }
    if (statusCode < 200 || statusCode >= 300) {
      throw ServerException(statusCode: statusCode);
    }

    final Object? body;
    try {
      body = jsonDecode(utf8.decode(response.bodyBytes));
    } on FormatException {
      throw ServerException(statusCode: statusCode);
    }
    if (body is Map<String, dynamic>) return body;
    throw ServerException(statusCode: statusCode);
  }
}
