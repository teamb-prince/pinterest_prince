import 'dart:convert';

import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';

abstract class PinsApi {
  Future<PinModel> getPin(String id);

  Future<List<PinModel>> getPins(
      {String userId, String boardId, int limit, int offset});

  Future<PinModel> savePin(PinRequestModel pinRequestModel);
}

class DefaultPinsApi extends PinsApi {
  DefaultPinsApi(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<PinModel> getPin(String id) async {
    final response = await _apiClient.get('/pins/$id');
    return PinModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  @override
  Future<List<PinModel>> getPins(
      {String userId, String boardId, int limit, int offset}) async {
    // ここもっといい書き方ないかな？
    final response = await _apiClient.get(
        '/pins?user_id={$userId}&board_id={$boardId}&limit={$limit}&offset={$offset}');
    return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
        .map((pin) => PinModel.fromJson(pin))
        .toList();
  }

  @override
  Future<PinModel> savePin(PinRequestModel pinRequestModel) async {
    // jsonに
    final response =
        await _apiClient.post('/pins/url', body: pinRequestModel.toJson());
    return PinModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
}
