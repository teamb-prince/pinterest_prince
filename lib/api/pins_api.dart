import 'dart:convert';
import 'dart:io';

import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';

abstract class PinsApi {
  Future<PinModel> getPin(String id);

  Future<List<PinModel>> getPins(
      {String userId, String boardId, int limit, int offset});

  Future<PinModel> savePinWithUrl(PinRequestModel pinRequestModel);

  Future<PinModel> savePinWithImage(
      File image, PinRequestModel pinRequestModel);
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
    Map<String, String> query = {};
    if (userId != null) {
      query['user_id'] = userId;
    }
    if (boardId != null) {
      query['board_id'] = boardId;
    }
    if (limit != null) {
      query['limit'] = limit.toString();
    }
    if (offset != null) {
      query['offset'] = offset.toString();
    }
    final response = await _apiClient.get('/pins', query: query);
    return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
        .map((pin) => PinModel.fromJson(pin))
        .toList();
  }

  @override
  Future<PinModel> savePinWithUrl(PinRequestModel pinRequestModel) async {
    final response =
        await _apiClient.post('/pins/url', body: pinRequestModel.toJson());
    return PinModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  @override
  Future<PinModel> savePinWithImage(
      File image, PinRequestModel pinRequestModel) async {
    final response = await _apiClient.multiPartPost('/pins/local',
        image: image, json: pinRequestModel.toJson());
    return PinModel.fromJson(jsonDecode(response));
  }
}
