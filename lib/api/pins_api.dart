import 'dart:convert';

import 'package:http/http.dart';
import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/model/pin_model.dart';

abstract class PinsApi {
  Future<PinModel> getPin(String id);

  Future<List<PinModel>> getPins();
}

class DefaultPinsApi extends PinsApi {
  final ApiClient _apiClient;

  DefaultPinsApi(this._apiClient);

  @override
  Future<PinModel> getPin(String id) async {
    final Response response = await _apiClient.get("/pins/$id");
    return PinModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  @override
  Future<List<PinModel>> getPins() async {
    final Response response = await _apiClient.get("/pins");
    return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
        .map((pin) => PinModel.fromJson(pin))
        .toList();
  }
}
