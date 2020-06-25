import 'dart:convert';

import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/model/image_model.dart';

// ignore: one_member_abstracts
abstract class ImageApi {
  Future<ImageModel> crawlingImageFromUrl(String url);
}

class DefaultImageApi extends ImageApi {
  DefaultImageApi(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<ImageModel> crawlingImageFromUrl(String url) async {
    final body = jsonEncode({'url': url});
    final response = await _apiClient.post('/images/url-images', body: body);
    return ImageModel.fromJson(jsonDecode(response.body));
  }
}
