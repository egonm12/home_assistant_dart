import 'dart:io';

import 'package:http/http.dart' as http;

class Client extends http.BaseClient {
  final http.Client _httpClient = http.Client();

  Client({
    required this.token,
  });

  final String token;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    return _httpClient.send(request);
  }
}
