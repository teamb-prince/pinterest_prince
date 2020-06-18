import 'dart:convert';

import 'package:http/http.dart';
import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/model/sign_in_request_model.dart';

abstract class AuthApi {
  Future<String> signIn(SignInRequestModel signInRequestModel);
}

class DefaultAuthApi extends AuthApi {
  DefaultAuthApi(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<String> signIn(SignInRequestModel signInRequestModel) async {
    final Response response =
        await _apiClient.post('login', body: signInRequestModel.toJson());
    /*
    {
      "token": {JWT}
    }
    みたいな形式を想定してるので、とりあえずこの形で。
    サーバー側の実装に応じて変更します。
     */
    return jsonDecode(response.body)['token'] as String;
  }
}
