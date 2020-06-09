import 'dart:convert';

import 'package:http/http.dart';
import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/model/image_model.dart';

abstract class ImageApi {
  Future<ImageModel> searchImageFromUrl(String url);
}

class DefaultImageApi extends ImageApi {
  final ApiClient _apiClient;

  DefaultImageApi(this._apiClient);

  @override
  Future<ImageModel> searchImageFromUrl(String url) async {
    final String body = jsonEncode({
      'url': url
    });
    final Response response = await _apiClient.post("/image", body: body);
    return ImageModel.fromJson(jsonDecode(response.body));
  }
}