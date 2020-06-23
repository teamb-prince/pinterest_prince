import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';

abstract class PinsApi {
  Future<PinModel> getPin(String id);

  Future<List<PinModel>> getPins();

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
  Future<List<PinModel>> getPins() async {
    final response = await _apiClient.get('/pins');
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
    // ここで_apiClientのpostを呼び出す形で書けないのが微妙
    final request = http.MultipartRequest(
        'POST', Uri.parse('http://localhost:8080/pins/local'));
    request.fields['json'] = pinRequestModel.toString();
    request.files.add(http.MultipartFile.fromBytes(
        'image', image.readAsBytesSync(),
        filename: 'image'));
    final response = await request.send();
    final body = await response.stream.bytesToString();
    return PinModel.fromJson(jsonDecode(body));
  }
}
