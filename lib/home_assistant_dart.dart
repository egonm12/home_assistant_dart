import 'dart:convert';

import 'package:home_assistant_dart/src/client.dart';

class HomeAssistantDart {
  HomeAssistantDart({
    required this.token,
    required this.baseUrl,
  }) : client = Client(token: token);

  late final Client client;
  late final String token;
  late final String baseUrl;

  /// [getState]
  /// Returns a state object for specified [entityId]. Returns 404 if not found.
  Future<dynamic> getState(String entityId) async {
    final Uri url = Uri.parse('$baseUrl/states/$entityId');

    try {
      final response = await client.get(url);

      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  /// [setState]
  /// Updates or creates a state. You can create any state that you want, it does
  /// not have to be backed by an entity in Home Assistant.
  ///
  /// This endpoint sets the representation of a device within Home Assistant and
  /// will not communicate with the actual device. To communicate with the device,
  /// use the [callService] method
  Future<dynamic> setState(String entityId, String newState,
      [Map? attributes]) async {
    final Uri url = Uri.parse('$baseUrl/states/$entityId');

    try {
      final response = await client.post(url, body: {
        'state': newState,
        // 'attributes': attributes ?? {},
      });

      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  /// [callService]
  /// Calls a [service] within a specific [domain]. Will return when the [service] has
  /// been executed or after 10 seconds, whichever comes first.
  //
  // You can pass an optional JSON object [data] to be used as service_data.
  Future<dynamic> callService(String domain, String service,
      [Map? data]) async {
    final Uri url = Uri.parse('$baseUrl/services/$domain/$service');

    try {
      final response = await client.post(url, body: json.encode(data));
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }
}
